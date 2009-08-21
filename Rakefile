# vim: set filetype=ruby et sw=2 ts=2:

begin
  require 'rake/gempackagetask'
rescue LoadError
end
require 'rake/clean'
require 'rbconfig'
include Config

PKG_NAME = 'file-tail'
PKG_VERSION = File.read('VERSION').chomp
PKG_FILES = FileList["**/*"].exclude(/^(pkg|coverage|doc)/)
CLEAN.include 'coverage', 'doc'

desc "Installing library"
task :install  do
  ruby 'install.rb'
end

desc "Creating documentation"
task :doc do
  ruby 'make_doc.rb'
end

desc "Testing library"
task :test  do
  ruby %{-Ilib tests/test_file-tail.rb}
end

desc "Testing library with rcov"
task :coverage  do
  system %{rcov -x '\\btests\/' -Ilib tests/test_file-tail.rb}
end

if defined? Gem
  spec_src =<<GEM
# -*- encoding: utf-8 -*-
Gem::Specification.new do |s|
  s.name = '#{PKG_NAME}'
  s.version = '#{PKG_VERSION}'
  s.summary = "File::Tail for Ruby"
  s.description = "Library to tail files in Ruby"

  s.files = #{PKG_FILES.to_a.sort.inspect}

  s.require_path = 'lib'

  s.has_rdoc = true
  s.rdoc_options << '--main' <<  'doc-main.txt'
  s.extra_rdoc_files << 'doc-main.txt'
  s.test_files << 'tests/test_file-tail.rb'

  s.author = "Florian Frank"
  s.email = "flori@ping.de"
  s.homepage = "http://#{PKG_NAME}.rubyforge.org"
  s.rubyforge_project = "#{PKG_NAME}"
end
GEM

  desc 'Create a gemspec file'
  task :gemspec do
    File.open("#{PKG_NAME}.gemspec", 'w') do |f|
      f.puts spec_src
    end
  end

  spec = eval(spec_src)
  Rake::GemPackageTask.new(spec) do |pkg|
    pkg.need_tar = true
    pkg.package_files += PKG_FILES
  end
end

desc m = "Writing version information for #{PKG_VERSION}"
task :version do
  puts m
  File.open(File.join('lib', 'file', 'tail', 'version.rb'), 'w') do |v|
    v.puts <<EOT
class File
  module Tail
    # File::Tail version
    VERSION         = '#{PKG_VERSION}'
    VERSION_ARRAY   = VERSION.split(/\\./).map { |x| x.to_i } # :nodoc:
    VERSION_MAJOR   = VERSION_ARRAY[0] # :nodoc:
    VERSION_MINOR   = VERSION_ARRAY[1] # :nodoc:
    VERSION_BUILD   = VERSION_ARRAY[2] # :nodoc:
  end
end
EOT
  end
end

task :default => [ :version, :gemspec, :test ]

task :release => [ :clean, :version, :gemspec, :package ]
