lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'device_map/version'

Gem::Specification.new do |spec|
  spec.name          = 'device_map'
  spec.version       = DeviceMap::VERSION
  spec.authors       = ['Konstantin Papkovskiy']
  spec.email         = ['konstantin@papkovskiy.com']
  spec.summary       = 'Ruby client for Apache DeviceMap'
  spec.description   = <<-EOD
    Ruby implementation of client for Apache DeviceMap repository
    containing device information, images and other relevant
    information for all sorts of mobile devices.
  EOD

  spec.homepage      = 'https://github.com/soylent/device_map'
  spec.license       = 'Apache-2.0'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(/^bin\//) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(/^spec\//)
  spec.require_paths = ['lib']

  spec.add_dependency 'nokogiri', '~> 1.6'

  spec.add_development_dependency 'bundler', '~> 1.7'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.1'

  spec.add_development_dependency 'pry', '~> 0.10'
end
