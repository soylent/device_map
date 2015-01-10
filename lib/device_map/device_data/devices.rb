module DeviceMap
  module DeviceData
    class Devices
      class DeviceNotFound < StandardError; end

      def self.parse(devices_xml)
        devices_doc = Nokogiri::XML(devices_xml)
        devices = devices_doc.xpath('//device').map do |device_node|
          Device.parse(device_node)
        end

        new(devices)
      end

      def initialize(devices)
        @device_index = devices.each_with_object({}) do |device, device_index|
          device_index[device.id] = device
        end
      end

      def find(device_id)
        # TODO: Return copy of <tt>Device</tt> object
        @device_index.fetch(device_id) do
          fail DeviceNotFound, "Cound not find device: #{device_id}"
        end
      end
    end
  end
end
