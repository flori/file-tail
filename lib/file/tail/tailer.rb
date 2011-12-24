class File
  module Tail
    # This class supervises activity on a tailed fail and collects newly read
    # lines until the Tail::Group fetches and processes them.
    class Tailer < ::Thread

      # True if there are any lines pending on this Tailer, false otherwise.
      def pending_lines?
        !queue.empty?
      end

      # Fetch all the pending lines from this Tailer and thereby remove them
      # from the Tailer's queue.
      def pending_lines
        Array.new(queue.size) { queue.deq(true) }
      end

      alias stop exit # Stop tailing this file and remove it from its File::Tail::Group.

      # Return true if the thread local variable +id+ is defined or if this
      # object responds to the method +id+.
      def respond_to?(id)
        !self[id].nil? || super
      end

      # Return the thread local variable +id+ if it is defined.
      def method_missing(id, *args, &block)
        if args.empty? && !(value = self[id]).nil?
          value
        else
          super
        end
      end
    end
  end
end
