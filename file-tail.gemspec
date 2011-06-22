# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{file-tail}
  s.version = "1.0.6"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = [%q{Florian Frank}]
  s.date = %q{2011-06-21}
  s.description = %q{Library to tail files in Ruby}
  s.email = %q{flori@ping.de}
  s.executables = [%q{rtail}]
  s.extra_rdoc_files = [%q{README}]
  s.files = [%q{tests}, %q{tests/test_file-tail.rb}, %q{examples}, %q{examples/tail.rb}, %q{examples/pager.rb}, %q{COPYING}, %q{file-tail.gemspec}, %q{Rakefile}, %q{make_doc.rb}, %q{lib}, %q{lib/file}, %q{lib/file/tail.rb}, %q{lib/file/tail}, %q{lib/file/tail/version.rb}, %q{CHANGES}, %q{bin}, %q{bin/rtail}, %q{README}, %q{VERSION}, %q{install.rb}]
  s.homepage = %q{http://flori.github.com/file-tail}
  s.rdoc_options = [%q{--main}, %q{README}, %q{--title}, %q{File::Tail - Tailing files in Ruby}]
  s.require_paths = [%q{lib}]
  s.rubyforge_project = %q{file-tail}
  s.rubygems_version = %q{1.8.5}
  s.summary = %q{File::Tail for Ruby}
  s.test_files = [%q{tests/test_file-tail.rb}]

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<spruz>, [">= 0.1.0"])
    else
      s.add_dependency(%q<spruz>, [">= 0.1.0"])
    end
  else
    s.add_dependency(%q<spruz>, [">= 0.1.0"])
  end
end
