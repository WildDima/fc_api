$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "fc_api/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "fc_api"
  s.version     = FcApi::VERSION
  s.authors     = ["WildDima"]
  s.email       = ["dtopornin@gmail.com"]
  s.homepage    = "http://github.com/WildDima/fc_api"
  s.summary     = "Summary of FcApi."
  s.description = "Description of FcApi."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["spec/**/*"]

  s.add_dependency "rails", "~> 4.2.6"
  s.add_development_dependency 'rspec-rails', '~> 3.4'
  s.add_development_dependency 'rake'

  s.add_development_dependency "sqlite3"
end
