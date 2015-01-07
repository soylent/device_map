module DeviceMap
  module OpenDDR
    class Devices
      def initialize(devices_xml)
        @devices = {}

        devices_doc = Nokogiri::XML(devices_xml)
        devices_doc.xpath('//device').each do |device_node|
          @devices[device_node[:id]] = Device.parse(device_node)
        end
      end

      def find(device_id)
        # TODO: Return copy of <tt>Device</tt> object
        @devices[device_id]
      end
    end
  end
end
