require 'nokogiri'

module DeviceMap
  autoload :Device, 'device_map/device'
  autoload :UserAgent, 'device_map/user_agent'
  autoload :VERSION, 'device_map/version'

  module OpenDDR
    autoload :Builder, 'device_map/openddr/builder'
    autoload :Patterns, 'device_map/openddr/patterns'
  end

  def self.classify(user_agent)
    Device.new
  end
end
