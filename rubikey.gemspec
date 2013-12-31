# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rubikey/version'

Gem::Specification.new do |spec|
  spec.name          = "rubikey"
  spec.version       = Rubikey::VERSION
  spec.authors       = ["Sigfrid Dusci"]
  spec.email         = ["sig@farmatotum.com"]
  spec.summary       = %q{Ruby library for YubiKey OTPs.}
  spec.description   = %q{Another Ruby library for verifying, decoding, decrypting and parsing YubiKey OTPs.}
  spec.homepage      = "https://github.com/sigfrid/rubikey"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec", "~> 2.14.0"
end
