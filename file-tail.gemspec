# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "file-tail"
  s.version = "1.0.12"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Florian Frank"]
  s.date = "2012-10-02"
  s.description = "Library to tail files in Ruby"
  s.email = "flori@ping.de"
  s.extra_rdoc_files = ["README.rdoc", "lib/file/tail/group.rb", "lib/file/tail/line_extension.rb", "lib/file/tail/logfile.rb", "lib/file/tail/tailer.rb", "lib/file/tail/version.rb", "lib/file/tail.rb", "lib/file-tail.rb"]
  s.files = [".gitignore", ".travis.yml", "CHANGES", "COPYING", "Gemfile", "README.rdoc", "Rakefile", "VERSION", "bin/rtail", "examples/pager.rb", "examples/tail.rb", "file-tail.gemspec", "lib/file-tail.rb", "lib/file/tail.rb", "lib/file/tail/group.rb", "lib/file/tail/line_extension.rb", "lib/file/tail/logfile.rb", "lib/file/tail/tailer.rb", "lib/file/tail/version.rb", "tests/file_tail_group_test.rb", "tests/file_tail_test.rb", "tests/test_helper.rb"]
  s.homepage = "http://github.com/flori/file-tail"
  s.rdoc_options = ["--title", "File-tail - File::Tail for Ruby", "--main", "README.rdoc"]
  s.require_paths = ["lib"]
  s.rubygems_version = "1.8.24"
  s.summary = "File::Tail for Ruby"
  s.test_files = ["tests/file_tail_group_test.rb", "tests/file_tail_test.rb", "tests/test_helper.rb"]

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<gem_hadar>, ["~> 0.1.8"])
      s.add_development_dependency(%q<test-unit>, ["~> 2.4.0"])
      s.add_runtime_dependency(%q<tins>, ["~> 0.5"])
    else
      s.add_dependency(%q<gem_hadar>, ["~> 0.1.8"])
      s.add_dependency(%q<test-unit>, ["~> 2.4.0"])
      s.add_dependency(%q<tins>, ["~> 0.5"])
    end
  else
    s.add_dependency(%q<gem_hadar>, ["~> 0.1.8"])
    s.add_dependency(%q<test-unit>, ["~> 2.4.0"])
    s.add_dependency(%q<tins>, ["~> 0.5"])
  end
end
