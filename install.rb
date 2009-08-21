#!/usr/bin/env ruby

require 'rbconfig'
require 'fileutils'
include FileUtils::Verbose

include Config

cd 'lib' do
  libdir = CONFIG["sitelibdir"]

  dest = File.join(libdir, 'file')
  mkdir_p(dest)
  file = File.join('file', 'tail.rb')
  install(file, dest)

  dest = File.join(dest, 'tail')
  mkdir_p(dest)
  file = File.join('file', 'tail', 'version.rb')
  install(file, dest)
end
