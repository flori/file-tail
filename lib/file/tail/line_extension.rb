class File
  module Tail
    # This module is used to extend all lines received via one of the tailers
    # of a File::Tail::Group.
    module LineExtension
      # The file as a File instance this line was read from.
      def file
        tailer.file
      end

      # This is the tailer this line was received from.
      attr_reader :tailer
    end
  end
end
