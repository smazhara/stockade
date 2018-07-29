lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'stockade/version'

Gem::Specification.new do |spec|
  spec.name          = 'stockade'
  spec.version       = Stockade::VERSION
  spec.authors       = ['Stan Mazhara']
  spec.email         = ['akmegran@gmail.com']

  spec.summary       = %q{Stockade is a lexer for PII}
  spec.description   = %q{
    Stockade is a lexer that reads unstructured text information (from files,
    logs, databases etc.) and tokenizes pieces that look like personally
    identifiable information (PII).
  }
  spec.homepage      = 'https://github.com/smazhara/stockade'
  spec.license       = 'MIT'

  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files`.split(/\n/).reject { |f| f.match(%r{^(test|spec|features)/}) }
  end

  spec.add_development_dependency 'bundler', '~> 1.16'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'

  spec.add_runtime_dependency 'bloomfilter-rb', '~> 2.0'
  spec.add_runtime_dependency 'memoist', '~> 0.1'
end
