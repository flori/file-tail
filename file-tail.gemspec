# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{file-tail}
  s.version = "1.0.7"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Florian Frank"]
  s.date = %q{2011-07-15}
  s.description = %q{Library to tail files in Ruby}
  s.email = %q{flori@ping.de}
  s.extra_rdoc_files = ["README.rdoc"]
  s.files = [".gitignore", "CHANGES", "COPYING", "Gemfile", "README.rdoc", "Rakefile", "VERSION", "bin/rtail", "examples/pager.rb", "examples/tail.rb", "file-tail.gemspec", "lib/file-tail.rb", "lib/file/tail.rb", "lib/file/tail/group.rb", "lib/file/tail/line_extension.rb", "lib/file/tail/logfile.rb", "lib/file/tail/tailer.rb", "lib/file/tail/version.rb", "tests/test_file-tail.rb", "tests/test_file-tail_group.rb"]
  s.homepage = %q{http://github.com/flori/file-tail}
  s.rdoc_options = ["--title", "File-tail - File::Tail for Ruby", "--main", "README.rdoc"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.6.2}
  s.summary = %q{File::Tail for Ruby}
  s.test_files = ["tests/test_file-tail_group.rb", "tests/test_file-tail.rb"]

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<gem_hadar>, ["~> 0.0.0"])
      s.add_runtime_dependency(%q<spruz>, ["~> 0.2"])
    else
      s.add_dependency(%q<gem_hadar>, ["~> 0.0.0"])
      s.add_dependency(%q<spruz>, ["~> 0.2"])
    end
  else
    s.add_dependency(%q<gem_hadar>, ["~> 0.0.0"])
    s.add_dependency(%q<spruz>, ["~> 0.2"])
  end
end
