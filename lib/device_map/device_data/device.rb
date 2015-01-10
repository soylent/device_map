require 'ostruct'

module DeviceMap
  module DeviceData
    class Device < OpenStruct
      UNKNOWN_ID = 'unknown'

      def self.parse(device_node)
        properties = device_node.xpath('property')
        attrs = properties.each_with_object({}) do |property, result|
          result[property[:name]] = property[:value]
        end

        new(attrs.merge(id: device_node[:id]))
      end

      def self.unknown
        new(id: UNKNOWN_ID)
      end
    end
  end
end
