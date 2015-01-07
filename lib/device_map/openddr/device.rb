module DeviceMap
  module OpenDDR
    class Device
      def self.parse(device_node)
        new(id: device_node[:id])
      end

      attr_reader :id

      def initialize(attrs)
        @id = attrs.fetch(:id)
      end
    end
  end
end
