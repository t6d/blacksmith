# -*- encoding: utf-8 -*-
require File.expand_path('../lib/blacksmith/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Konstantin Tennhard"]
  gem.email         = ["me@t6d.de"]
  gem.summary       = %q{Blacksmith uses FontForge to build fonts from SVG graphics}
  gem.homepage      = "http://github.com/t6d/blacksmith"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "blacksmith"
  gem.require_paths = ["lib"]
  gem.version       = Blacksmith::VERSION
  
  gem.add_dependency "smart_properties", "~> 1.0"
end
