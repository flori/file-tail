# -*- encoding: utf-8 -*-
Gem::Specification.new do |s|
  s.name = 'file-tail'
  s.version = '1.0.4'
  s.summary = "File::Tail for Ruby"
  s.description = "Library to tail files in Ruby"

  s.files = ["CHANGES", "COPYING", "README", "Rakefile", "VERSION", "examples", "examples/pager.rb", "examples/tail.rb", "file-tail.gemspec", "install.rb", "lib", "lib/file", "lib/file/tail", "lib/file/tail.rb", "lib/file/tail/version.rb", "make_doc.rb", "tests", "tests/test_file-tail.rb"]

  s.require_path = 'lib'

  s.has_rdoc = true
  s.rdoc_options << '--main' <<  'doc-main.txt'
  s.extra_rdoc_files << 'doc-main.txt'
  s.test_files << 'tests/test_file-tail.rb'

  s.author = "Florian Frank"
  s.email = "flori@ping.de"
  s.homepage = "http://file-tail.rubyforge.org"
  s.rubyforge_project = "file-tail"
end
