# -*- encoding: utf-8 -*-
# stub: file-tail 1.1.0 ruby lib

Gem::Specification.new do |s|
  s.name = "file-tail"
  s.version = "1.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Florian Frank"]
  s.date = "2014-09-26"
  s.description = "Library to tail files in Ruby"
  s.email = "flori@ping.de"
  s.extra_rdoc_files = ["README.rdoc", "lib/file-tail.rb", "lib/file/tail.rb", "lib/file/tail/group.rb", "lib/file/tail/line_extension.rb", "lib/file/tail/logfile.rb", "lib/file/tail/tailer.rb", "lib/file/tail/version.rb"]
  s.files = [".gitignore", ".travis.yml", "CHANGES", "COPYING", "Gemfile", "README.rdoc", "Rakefile", "VERSION", "bin/rtail", "examples/pager.rb", "examples/tail.rb", "file-tail.gemspec", "lib/file-tail.rb", "lib/file/tail.rb", "lib/file/tail/group.rb", "lib/file/tail/line_extension.rb", "lib/file/tail/logfile.rb", "lib/file/tail/tailer.rb", "lib/file/tail/version.rb", "tests/file_tail_group_test.rb", "tests/file_tail_test.rb", "tests/test_helper.rb"]
  s.homepage = "http://github.com/flori/file-tail"
  s.licenses = ["GPL-2.0"]
  s.rdoc_options = ["--title", "File-tail - File::Tail for Ruby", "--main", "README.rdoc"]
  s.rubygems_version = "2.2.2"
  s.summary = "File::Tail for Ruby"
  s.test_files = ["tests/file_tail_group_test.rb", "tests/file_tail_test.rb", "tests/test_helper.rb"]

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<gem_hadar>, ["~> 1.0.0"])
      s.add_development_dependency(%q<test-unit>, ["~> 2.4.0"])
      s.add_runtime_dependency(%q<tins>, ["~> 1.0"])
    else
      s.add_dependency(%q<gem_hadar>, ["~> 1.0.0"])
      s.add_dependency(%q<test-unit>, ["~> 2.4.0"])
      s.add_dependency(%q<tins>, ["~> 1.0"])
    end
  else
    s.add_dependency(%q<gem_hadar>, ["~> 1.0.0"])
    s.add_dependency(%q<test-unit>, ["~> 2.4.0"])
    s.add_dependency(%q<tins>, ["~> 1.0"])
  end
end
