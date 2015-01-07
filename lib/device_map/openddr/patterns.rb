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
        @pattern_index = {}

        builders.each do |builder|
          builder.patterns.each do |pattern|
            @pattern_index[pattern.keyword] ||= Set.new
            @pattern_index[pattern.keyword] << pattern
          end
        end
      end

      def find(keyword)
        # TODO: Return copy of the set
        @pattern_index.fetch(keyword) do
          Set.new
        end
      end
    end
  end
end
