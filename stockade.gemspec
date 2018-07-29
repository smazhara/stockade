lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'stockade/version'

Gem::Specification.new do |spec|
  spec.name          = 'stockade'
  spec.version       = Stockade::VERSION
  spec.authors       = ['Stan Mazhara']
  spec.email         = ['akmegran@gmail.com']

  spec.summary       = %q{Stockade is a lexer for PII}
  # spec.description   = %q{TODO: Write a longer description or delete this line.}
  spec.homepage      = 'https://github.com/smazhara/stockade'
  spec.license       = 'MIT'
  #
  # # Specify which files should be added to the gem when it is released.
  # # The `git ls-files -z` loads the files in the RubyGem that have been added into git.

  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files`.split(/\n/).reject { |f| f.match(%r{^(test|spec|features)/}) }
  end

  # spec.bindir        = 'exe'
  # spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  # spec.require_paths = ['lib']
  #
  spec.add_development_dependency 'bundler', '~> 1.16'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'

  spec.add_runtime_dependency 'bloomfilter-rb'
  spec.add_runtime_dependency 'memoist'
end
