module DeviceMap
  module OpenDDR
    class Patterns
      def self.parse(openddr_builder_xml)
        builders_doc = Nokogiri::XML(openddr_builder_xml)
        openddr_builders = builders_doc.xpath('//builder')

        builders = openddr_builders.map do |builder_node|
          Builder.find(builder_node)
        end

        new(builders)
      end

      def initialize(builders)
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
        # TODO: Return copy of the set
        @patterns.fetch(keyword) do
          Set.new
        end
      end
    end
  end
end
