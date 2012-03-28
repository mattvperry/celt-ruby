# -*- encoding: utf-8 -*-
require File.expand_path('../lib/celt-ruby/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Matthew Perry"]
  gem.email         = ["perrym5@rpi.edu"]
  gem.description   = %q{Ruby FFI Gem for the CELT Audio Codec}
  gem.homepage      = ""

  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.name          = "celt-ruby"
  gem.require_paths = ["lib"]
  gem.version       = Celt::VERSION
end
