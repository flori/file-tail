require 'thread'

class File
  module Tail
    # This class can be used to coordinate tailing of many files, which have
    # been added to the group.
    class Group
      # Creates a new File::Tail::Group instance.
      #
      # The following options can be given as arguments:
      # :files:: an array of files (or filenames to open) that are placed into
      #          the group.
      def initialize(opts = {})
        @tailers = ThreadGroup.new
        if files = opts[:files]
          Array(files).each { |file| add file }
        end
      end

      # Creates a group for +files+ (IO instances or filename strings).
      def self.[](*files)
        new(:files => files)
      end

      # Add a file (IO instance) or filename (responding to to_str) to this
      # group.
      def add(file_or_filename)
        if file_or_filename.respond_to?(:to_io)
          add_file file_or_filename.to_io
        elsif file_or_filename.respond_to?(:to_str)
          add_filename file_or_filename
        end
      end

      alias << add

      # Add the IO instance +file+ to this group.
      def add_file(file)
        setup_file_tailer file
        self
      end

      # Add a file created by opening +filename+ to this group after stepping
      # +n+ lines backwards from the end of it.
      def add_filename(filename, n = 0)
        file = Logfile.open(filename.to_str, :backward => n)
        file.backward n
        setup_file_tailer file
        self
      end

      # Iterate over all files contained in this group yielding to +block+ for
      # each of them.
      def each_file(&block)
        each_tailer { |t| t.file }.map(&block)
      end

      # Iterate over all tailers in this group yielding to +block+ for each of
      # them.
      def each_tailer(&block)
        @tailers.list.map(&block)
      end

      # Stop all tailers in this group at once.
      def stop
        each_tailer { |t| t.stop }
        each_tailer { |t| t.join }
        self
      end

      # Tail all the lines of all the files in the Tail::Group instance, that
      # is yield to each of them.
      #
      # Every line is extended with the LineExtension module, that adds some
      # methods to the line string. To get the path of the file this line was
      # received from call line.file.path.
      def tail
        wait_for_activity do |tailer|
          tailer.pending_lines.each do |line|
            line.extend LineExtension
            line.instance_variable_set :@tailer, tailer
            yield line
          end
        end
      end

      private

      def setup_file_tailer(file)
        file.extend File::Tail
        setup = ConditionVariable.new
        mutex = Mutex.new
        ft = nil
        mutex.synchronize do
          ft = Tailer.new do
            t = Thread.current
            t[:queue] = Queue.new
            t[:file]  = file
            mutex.synchronize do
              setup.signal
            end
            file.tail { |line| t[:queue] << line }
          end
          setup.wait mutex
        end
        @tailers.add ft
        nil
      end

      # Wait until new input is receіved on any of the tailers in the group. If
      # so call +block+ with all of these trailers as an argument.
      def wait_for_activity(&block)
        loop do
          pending = each_tailer.select(&:pending_lines?)
          if pending.empty?
            interval = each_file.map { |t| t.interval }.compact.min || 0.1
            sleep interval
          else
            pending.each(&block)
          end
        end
      end
    end
  end
end
