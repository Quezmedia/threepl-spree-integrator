# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'nutracoapi/version'

Gem::Specification.new do |spec|
  spec.name          = "nutracoapi"
  spec.version       = Nutracoapi::VERSION
  spec.authors       = ["Filipe Chagas"]
  spec.email         = ["filipe@ochagas.com"]
  spec.description   = %q{Handling with calls for nutraco api}
  spec.summary       = %q{Handling with calls for nutraco api}
  spec.homepage      = "http://www.quezmedia.com"

  spec.files = Dir["{config,lib}/**/*", "Rakefile", "README.md"]
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "savon", "~> 2.3.0"
  spec.add_development_dependency 'rspec-rails', '2.14.0'
end
