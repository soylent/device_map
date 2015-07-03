require 'set'

module DeviceMap
  module DeviceData
    # User agent classification patterns
    class Patterns
      # Parses OpenDDR builder XML
      #
      # @param openddr_builder_xml [String] XML
      # @return [DeviceMap::DeviceData::Patterns]
      def self.parse(openddr_builder_xml) # rubocop:disable Metrics/MethodLength
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

      # @param all_patterns [DeviceMap::Pattern] a list of patterns
      def initialize(all_patterns)
        @pattern_index = {}

        all_patterns.each do |pattern|
          pattern.keywords.each do |keyword|
            @pattern_index[keyword] ||= Set.new
            @pattern_index[keyword] << pattern
          end
        end
      end

      # Return all patterns for a given keyword
      #
      # @param keyword [String] keyword
      # @return [Set<DeviceMap::DeviceData::Pattern>] a set of patterns
      def find(keyword)
        pattern_set = @pattern_index.fetch(keyword) { Set.new }
        pattern_set.freeze
      end
    end
  end
end
