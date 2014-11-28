# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'puppet_spec_facts/version'

Gem::Specification.new do |spec|
  spec.name          = "puppet_spec_facts"
  spec.version       = PuppetSpecFacts::VERSION
  spec.authors       = ["Daniel Dreier"]
  spec.email         = ["d@puppetlabs.com"]
  spec.summary       = %q{Provide facter facts to rspec-puppet}
  spec.description   = %q{Support iteration of }
  spec.homepage      = "https://github.com/danieldreier/puppet_spec_facts"
  spec.license       = "Apache License, Version 2.0"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
end
