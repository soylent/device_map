require 'nokogiri'

module DeviceMap
  autoload :Pattern, 'device_map/pattern'
  autoload :UserAgent, 'device_map/user_agent'
  autoload :VERSION, 'device_map/version'

  module OpenDDR
    autoload :Builder, 'device_map/openddr/builder'
    autoload :Device, 'device_map/openddr/device'
    autoload :Devices, 'device_map/openddr/devices'
    autoload :Patterns, 'device_map/openddr/patterns'
  end
end
