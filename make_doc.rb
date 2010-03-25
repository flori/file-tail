#!/usr/bin/env ruby

$outdir = 'doc/'
puts "Creating documentation in '#$outdir'."
system "rdoc -m README -t 'File::Tail - Tailing files in Ruby' -o #$outdir README #{Dir['lib/**/*.rb'] * ' '}"
