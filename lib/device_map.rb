require 'nokogiri'

module DeviceMap
  autoload :Classifier, 'device_map/classifier'
  autoload :Keyword, 'device_map/keyword'
  autoload :Pattern, 'device_map/pattern'
  autoload :UserAgent, 'device_map/user_agent'
  autoload :VERSION, 'device_map/version'

  module OpenDDR
    autoload :Builder, 'device_map/openddr/builder'
    autoload :Device, 'device_map/openddr/device'
    autoload :Devices, 'device_map/openddr/devices'
    autoload :Patterns, 'device_map/openddr/patterns'
  end

  RESOURCES_PATH = File.expand_path('resources', __dir__)

  def self.classify(user_agent)
    classifier = Classifier.instance
    classifier.find_device(user_agent)
  end
end
