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
  ignore      '.*.sw[pon]', 'pkg', 'Gemfile.lock', 'coverage', '*.rbc', '.rbx'
  readme      'README.rdoc'

  dependency  'tins', '~>0.5'

  development_dependency 'test-unit', '~>2.4.0'

  install_library do
    cd 'lib' do
      libdir = CONFIG["sitelibdir"]

      dest = File.join(libdir, 'file')
      mkdir_p(dest)
      dest = File.join(libdir, path_name)
      install(path_name + '.rb', dest + '.rb', :verbose => true)
      mkdir_p(dest)
      for file in Dir[File.join(path_name, '*.rb')]
        install(file, dest, :verbose => true)
      end
    end
    bindir = CONFIG["bindir"]
    install('bin/rtail', bindir, :verbose => true, :mode => 0755)
  end
end
