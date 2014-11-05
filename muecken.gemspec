# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'muecken/version'

Gem::Specification.new do |spec|
  spec.name          = 'muecken'
  spec.version       = Muecken::VERSION
  spec.authors       = ['Daniel Sager']
  spec.email         = ['daniel@sager1.de']
  spec.summary       = 'Ruby library to parse and analyze financial data'
  spec.description   = 'Muecken (German for "mosquito", an informal word for money) is supposed to provide an easy way of parsing, analyzing and categorizing financial data to give you an overview of where money comes from and, most probably more important, where it goes.'
  spec.homepage      = 'https://github.com/dsager/muecken'
  spec.license       = 'MIT'
  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.6'
  spec.add_development_dependency 'rake'

  spec.add_dependency 'levenshtein', '~> 0.2'
end
