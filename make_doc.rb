#!/usr/bin/env ruby

$outdir = 'doc/'
puts "Creating documentation in '#$outdir'."
system "rdoc -m doc-main.txt -o #$outdir doc-main.txt #{Dir['lib/**/*.rb'] * ' '}"
