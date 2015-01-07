module DeviceMap
  module OpenDDR
    class Patterns
      def initialize(openddr_builder_xml)
        @patterns = {}

        openddr_patterns = Nokogiri::XML(openddr_builder_xml)
        openddr_patterns.xpath('//Builders/builder').each do |builder_node|
          builder = Builder.find(builder_node)
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
