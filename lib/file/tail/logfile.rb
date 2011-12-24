class File
  module Tail
    # This is an easy to use Logfile class that includes
    # the File::Tail module.
    #
    # === Usage
    # The unix command "tail -10f filename" can be emulated like that:
    #  File::Tail::Logfile.open(filename, :backward => 10) do |log|
    #    log.tail { |line| puts line }
    #  end
    #
    # Or a bit shorter:
    #  File::Tail::Logfile.tail(filename, :backward => 10) do |line|
    #    puts line
    #  end
    #
    # To skip the first 10 lines of the file do that:
    #  File::Tail::Logfile.open(filename, :forward => 10) do |log|
    #    log.tail { |line| puts line }
    #  end
    #
    # The unix command "head -10 filename" can be emulated like that:
    #  File::Tail::Logfile.open(filename, :return_if_eof => true) do |log|
    #    log.tail(10) { |line| puts line }
    #  end
    class Logfile < File
      include File::Tail

      # This method creates an File::Tail::Logfile object and
      # yields to it, and closes it, if a block is given, otherwise it just
      # returns it. The opts hash takes an option like
      # * <code>:backward => 10</code> to go backwards
      # * <code>:forward => 10</code> to go forwards
      # in the logfile for 10 lines at the start. The buffersize
      # for going backwards can be set with the
      # * <code>:bufsiz => 8192</code> option.
      # To define a callback, that will be called after a reopening occurs, use:
      # * <code>:after_reopen => lambda { |file| p file }</code>
      #
      # Every attribute of File::Tail can be set with a <code>:attributename =>
      # value</code> option.
      def self.open(filename, opts = {}, &block) # :yields: file
        file = new filename
        opts.each do |o, v|
          writer = o.to_s + "="
          file.__send__(writer, v) if file.respond_to? writer
        end
        if opts.key?(:wind) or opts.key?(:rewind)
          warn ":wind and :rewind options are deprecated, "\
            "use :forward and :backward instead!"
        end
        if backward = opts[:backward] || opts[:rewind]
          (args = []) << backward
          args << opt[:bufsiz] if opts[:bufsiz]
          file.backward(*args)
        elsif forward = opts[:forward] || opts[:wind]
          file.forward(forward)
        end
        if opts[:after_reopen]
          file.after_reopen(&opts[:after_reopen])
        end
        if block_given?
          begin
            block.call file
          ensure
            file.close
            nil
          end
        else
          file
        end
      end

      # Like open, but yields to every new line encountered in the logfile in
      # +block+.
      def self.tail(filename, opts = {}, &block)
        if ([ :forward, :backward ] & opts.keys).empty?
          opts[:backward] = 0
        end
        open(filename, opts) do |log|
          log.tail { |line| block.call line }
        end
      end
    end
  end
end
