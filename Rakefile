# vim: set filetype=ruby et sw=2 ts=2:

require 'gem_hadar'

GemHadar do
  name        'file-tail'
  path_name   'file/tail'
  author      'Florian Frank'
  email       'flori@ping.de'
  homepage    "http://github.com/flori/#{name}"
  summary     "#{path_name.camelize} for Ruby"
  description 'Library to tail files in Ruby'
  test_dir    'tests'
  ignore      '.*.sw[pon]', 'pkg', 'Gemfile.lock', 'coverage', '*.rbc', '.rbx',
    '.AppleDouble', '.bundle', 'errors.lst', '.utilsrc'
  readme      'README.md'
  licenses    << 'Apache-2.0'

  dependency  'tins', '~>1.0'

  development_dependency 'test-unit', '~>3.0'
  development_dependency 'all_images'
  development_dependency 'simplecov'
  development_dependency 'debug'
end
