# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'general_store/version'

Gem::Specification.new do |spec|
  spec.name          = "general_store"
  spec.version       = GeneralStore::VERSION
  spec.authors       = ["Stuart Nelson"]
  spec.email         = ["stuartnelson3@gmail.com"]
  spec.description   = %q{Get what you need from the General Store}
  spec.summary       = %q{Directory and attributes go in, attributes come out}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
end
