# -*- encoding: utf-8 -*-
# stub: file-tail 1.3.0 ruby lib

Gem::Specification.new do |s|
  s.name = "file-tail".freeze
  s.version = "1.3.0".freeze

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Florian Frank".freeze]
  s.date = "2024-09-13"
  s.description = "Library to tail files in Ruby".freeze
  s.email = "flori@ping.de".freeze
  s.extra_rdoc_files = ["README.md".freeze, "lib/file-tail.rb".freeze, "lib/file/tail.rb".freeze, "lib/file/tail/group.rb".freeze, "lib/file/tail/line_extension.rb".freeze, "lib/file/tail/logfile.rb".freeze, "lib/file/tail/tailer.rb".freeze, "lib/file/tail/version.rb".freeze]
  s.files = [".all_images.yml".freeze, ".gitignore".freeze, ".travis.yml".freeze, "CHANGES.md".freeze, "COPYING".freeze, "Gemfile".freeze, "README.md".freeze, "Rakefile".freeze, "VERSION".freeze, "bin/rtail".freeze, "examples/pager.rb".freeze, "examples/tail.rb".freeze, "file-tail.gemspec".freeze, "lib/file-tail.rb".freeze, "lib/file/tail.rb".freeze, "lib/file/tail/group.rb".freeze, "lib/file/tail/line_extension.rb".freeze, "lib/file/tail/logfile.rb".freeze, "lib/file/tail/tailer.rb".freeze, "lib/file/tail/version.rb".freeze, "tests/file_tail_group_test.rb".freeze, "tests/file_tail_test.rb".freeze, "tests/test_helper.rb".freeze]
  s.homepage = "http://github.com/flori/file-tail".freeze
  s.licenses = ["Apache-2.0".freeze]
  s.rdoc_options = ["--title".freeze, "File-tail - File::Tail for Ruby".freeze, "--main".freeze, "README.md".freeze]
  s.rubygems_version = "3.5.18".freeze
  s.summary = "File::Tail for Ruby".freeze
  s.test_files = ["tests/file_tail_group_test.rb".freeze, "tests/file_tail_test.rb".freeze, "tests/test_helper.rb".freeze]

  s.specification_version = 4

  s.add_development_dependency(%q<gem_hadar>.freeze, ["~> 1.17.1".freeze])
  s.add_development_dependency(%q<test-unit>.freeze, ["~> 3.0".freeze])
  s.add_development_dependency(%q<all_images>.freeze, [">= 0".freeze])
  s.add_development_dependency(%q<simplecov>.freeze, [">= 0".freeze])
  s.add_development_dependency(%q<debug>.freeze, [">= 0".freeze])
  s.add_runtime_dependency(%q<tins>.freeze, ["~> 1.0".freeze])
end
