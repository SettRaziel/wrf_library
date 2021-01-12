Gem::Specification.new do |s|
  s.name          = "wrf_library"
  s.version       = "0.3.0"
  s.summary       = "Ruby wrf file collection"
  s.description   = "Collection of common scripts and data structures for usage in other wrf related ruby projects"
  s.authors       = ["Benjamin Held"]
  s.email         = "me@bheld.eu"
  s.homepage      = "https://github.com/settraziel/wrf_library"
  s.licenses      = "MIT"

  s.files         = Dir["lib/**/*.rb"] + ["README.md", "LICENSE"]
  s.require_paths = ["lib"]

  s.required_ruby_version = ">= 2.4"

  s.add_development_dependency "rake",      '~> 13.0', '>= 13.0.1'
  s.add_development_dependency "rspec", '~> 3.9', '>= 3.9.0'
  s.add_dependency "ruby_utils", '~> 0.0.1'
end
