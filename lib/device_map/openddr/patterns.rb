module DeviceMap
  module OpenDDR
    class Patterns
      def initialize(*builders)
        @patterns = {}

        builders.each do |builder|
          builder.keywords_and_devices.each do |args|
            keyword, device_id = args
            @patterns[keyword] ||= Set.new
            @patterns[keyword] << device_id
          end
        end
      end

      def find(keyword)
        @patterns.fetch(keyword) do
          Set.new
        end
      end
    end
  end
end
