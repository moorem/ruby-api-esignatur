# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ruby/api/esignatur/version'

Gem::Specification.new do |spec|
  spec.name          = "ruby-api-esignatur"
  spec.version       = Ruby::Api::Esignatur::VERSION
  spec.authors       = ["Ankur Gupta"]
  spec.email         = ["ankur@moorem.com"]
  spec.summary       = %q{Electronic Signature using esignatur.dk}
  spec.description   = %q{The esignatur.dk provides methods for developers to integrate API in any ruby application.}
  spec.homepage      = "http://funnyobjects.com"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "minitest"
  spec.add_development_dependency "vcr"
  spec.add_development_dependency "webmock"

  spec.add_dependency "faraday"
  spec.add_dependency "json"

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
end