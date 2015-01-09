module DeviceMap
  module OpenDDR
    class Patterns
      def self.parse(openddr_builder_xml)
        builders_doc = Nokogiri::XML(openddr_builder_xml)
        openddr_builders = builders_doc.xpath('//builder')

        all_patterns = openddr_builders.flat_map do |builder_node|
          builder = Builder.find(builder_node)
          builder.patterns
        end

        new(all_patterns)
      end

      def initialize(all_patterns)
        @pattern_index = {}

        all_patterns.each do |pattern|
          pattern.keywords.each do |keyword|
            @pattern_index[keyword] ||= Set.new
            @pattern_index[keyword] << pattern
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
