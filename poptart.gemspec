# -*- encoding: utf-8 -*-

require File.expand_path('../lib/version', __FILE__)

Gem::Specification.new do |gem|
  gem.name          = 'poptart'
  gem.version       = Poptart::VERSION
  gem.authors       = ['Austen Ito']
  gem.email         = ['austen.dev@gmail.com']
  gem.homepage      = 'https://github.com/austenito/poptart'
  gem.summary       = 'The API client gem for the happines service'
  gem.description   = gem.summary
  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.require_paths = ['lib']
  gem.license = 'MIT'

  gem.add_dependency 'activesupport'
  gem.add_dependency 'hashie'
  gem.add_dependency 'faraday'
  gem.add_dependency 'addressable'

  gem.add_development_dependency 'pry'
  gem.add_development_dependency 'rspec'
  gem.add_development_dependency 'rake'
  gem.add_development_dependency 'vcr'
  gem.add_development_dependency 'webmock'
end
