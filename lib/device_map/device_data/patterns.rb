require 'set'

module DeviceMap
  module DeviceData
    class Patterns
      # rubocop:disable Metrics/MethodLength
      def self.parse(openddr_builder_xml)
        builders_doc = Nokogiri::XML(openddr_builder_xml)
        openddr_builders = builders_doc.xpath('//builder')

        all_patterns = openddr_builders.flat_map do |builder_node|
          builder_node_class = builder_node[:class]
          builder = Builder.find(builder_node_class)

          builder_node.xpath('device').flat_map do |device_node|
            device_id = device_node[:id]
            keywords = device_node.xpath('list/value').map(&:content)
            builder.patterns(device_id, keywords)
          end
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
