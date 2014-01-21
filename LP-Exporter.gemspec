# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'lp/exporter/version'

Gem::Specification.new do |spec|
  spec.name          = 'LP-Exporter'
  spec.version       = LP::Exporter::VERSION
  spec.authors       = ['Dāvis']
  spec.email         = ['davispuh@gmail.com']
  spec.summary       = 'Export langauge data from Microsoft language pack lp.cab files'
  spec.description   = 'Application to export langauge data from Microsoft language pack lp.cab files'
  spec.homepage      = 'https://github.com/davispuh/LP-Exporter'
  spec.license       = 'UNLICENSE'

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'libmspack'
  spec.add_runtime_dependency 'pedump'
  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'yard'
  spec.add_development_dependency 'simplecov'
end
