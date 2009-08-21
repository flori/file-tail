#!/usr/bin/env ruby
# A poor man's pager... :)

require 'file/tail'

filename = ARGV.shift or fail "Usage: #$0 filename [height]"
height = (ARGV.shift || ENV['LINES'] || 23).to_i - 1

File::Tail::Logfile.open(filename, :break_if_eof => true) do |log|
  begin
    log.tail(height) { |line| puts line }
    print "Press return key to continue!" ; gets
    print ""
    redo
  rescue File::Tail::BreakException
  end
end
