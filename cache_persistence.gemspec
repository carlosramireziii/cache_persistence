# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'cache_persistence/version'

Gem::Specification.new do |spec|
  spec.name          = "cache_persistence"
  spec.version       = CachePersistence::VERSION
  spec.authors       = ["Carlos Ramirez III"]
  spec.email         = ["carlos@cetrasoft.com"]
  spec.summary       = %q{ActiveRecord-style objects with persistence to the cache}
  spec.description   = %q{Prototype objects in the style of ActiveRecord without worrying about database migrations}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
end
