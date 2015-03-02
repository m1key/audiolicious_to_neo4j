# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'audiolicious_to_neo4j/version'

Gem::Specification.new do |spec|
  spec.name          = "audiolicious_to_neo4j"
  spec.version       = AudioliciousToNeo4j::VERSION
  spec.authors       = ["Mike Huniewicz"]
  spec.email         = ["michal.huniewicz.registered@gmail.com"]

  spec.summary       = 'Migration of iTunes library XML data to Neo4j.'
  spec.description   = 'This allows you to migrate iTunes library data in XML to Neo4j.'
  spec.homepage      = "https://github.com/m1key/audiolicious_to_neo4j"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "neo4j-core", ["= 4.0.2"]
  spec.add_runtime_dependency "nokogiri", "~> 1.6.6.2"
  spec.add_development_dependency "bundler", "~> 1.8"
  spec.add_development_dependency "rspec", "= 3.2.0"
  spec.add_development_dependency "rake", "~> 10.0"
end
