require 'ostruct'

module DeviceMap
  module OpenDDR
    class Device < OpenStruct
      def self.parse(device_node)
        properties = device_node.xpath('property')
        attrs = properties.each_with_object({}) do |property, result|
          result[property[:name]] = property[:value]
        end

        new(attrs.merge(id: device_node[:id]))
      end
    end
  end
end
