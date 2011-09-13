# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)

Gem::Specification.new do |s|
  s.name        = "guard-sync3r"
  s.version     = 1.0 
  s.authors     = ["James Welsh"]
  s.email       = ["james at supermatter dot com"]
  s.homepage    = "http://github.com/jwelshiv/guard-sync3r"
  s.summary     = %q{A simple guard library for syncing files with s3}
  s.description = %q{A simple guard library for syncing files with s3}

  s.rubyforge_project = "guard-sync3r"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency 'aws-s3'
  s.add_dependency 'guard'
end
