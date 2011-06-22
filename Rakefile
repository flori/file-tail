# vim: set filetype=ruby et sw=2 ts=2:

begin
  require 'rubygems/package_task'
rescue LoadError
end
require 'rake/clean'
require 'rbconfig'
include Config

PKG_NAME = 'file-tail'
PKG_VERSION = File.read('VERSION').chomp
PKG_FILES = FileList["**/*"].exclude(/^(pkg|coverage|doc|\..*|Gemfile.lock)/)
CLEAN.include 'coverage', 'doc'

desc "Install executable/library into site_ruby directories"
task :install  do
  cd 'lib' do
    libdir = CONFIG["sitelibdir"]

    dest = File.join(libdir, 'file')
    mkdir_p(dest)
    file = File.join('file', 'tail.rb')
    install(file, dest, :verbose => true)

    dest = File.join(dest, 'tail')
    mkdir_p(dest)
    for file in Dir[File.join('file', 'tail', '*.rb')]
      install(file, dest, :verbose => true)
    end
  end
  bindir = CONFIG["bindir"]
  install('bin/rtail', bindir, :verbose => true, :mode => 0755)
end

desc "Create documentation"
task :doc do
  sh "sdoc -m README.rdoc -t 'File::Tail - Tailing files in Ruby' README.rdoc #{Dir['lib/**/*.rb'] * ' '}"
end

desc "Testing library"
task :test  do
  ruby %{-Ilib tests/test_file-tail*.rb}
end

desc "Testing library with rcov"
task :coverage  do
  sh %{rcov -x '\\b/gems\/' -x '\\btests\/' -Ilib tests/test_file-tail*.rb}
end

namespace :gems do
  desc "Install all gems from the Gemfile"
  task :install  do
    sh 'bundle install'
  end
end

if defined? Gem
  spec = Gem::Specification.new do |s|
    s.name = PKG_NAME
    s.version = PKG_VERSION
    s.summary = "File::Tail for Ruby"
    s.description = "Library to tail files in Ruby"

    s.executables = 'rtail'
    s.files = PKG_FILES

    s.require_path = 'lib'

    s.add_dependency 'spruz', '~>0.2'

    s.rdoc_options << '--main' <<  'README.rdoc' << '--title' << 'File::Tail - Tailing files in Ruby'
    s.extra_rdoc_files << 'README.rdoc'
    s.test_files.concat Dir['tests/test_*.rb']

    s.author = "Florian Frank"
    s.email = "flori@ping.de"
    s.homepage = "http://flori.github.com/#{PKG_NAME}"
    s.rubyforge_project = PKG_NAME
  end

  desc 'Create a gemspec file'
  task :gemspec => :version do
    File.open('file-tail.gemspec', 'w') do |gemspec|
      gemspec.write spec.to_ruby
    end
  end

  Gem::PackageTask.new(spec) do |pkg|
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

desc "Run the tests by default"
task :default => [ :version, :test ]

desc "Prepare release of the library"
task :release => [ :clean, :gemspec, :package ]
