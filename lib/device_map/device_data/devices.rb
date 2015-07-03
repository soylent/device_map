module DeviceMap
  module DeviceData
    # Device database
    class Devices
      # Raises when a device is not found
      class DeviceNotFound < StandardError; end

      # Creates a list of devices
      #
      # @param devices_xml [String] XML fragment
      # @return [Array<DeviceMap::DeviceData::Device>]
      def self.parse(devices_xml)
        devices_doc = Nokogiri::XML(devices_xml)
        devices = devices_doc.xpath('//device').map do |device_node|
          Device.parse(device_node)
        end

        new(devices)
      end

      # @param devices [Array<DeviceMap::DeviceData::Device>] a list of devices
      def initialize(devices)
        @device_index = devices.each_with_object({}) do |device, device_index|
          device_index[device.id] = device
        end
      end

      # Looks up a device by a given device id
      #
      # @raise [DeviceNotFound] when the device is not found
      # @param device_id [String] device id
      # @return [DeviceMap::DeviceData::Device]
      def find(device_id)
        @device_index.fetch(device_id) do
          fail DeviceNotFound, "Cound not find device: #{device_id}"
        end
      end
    end
  end
end
