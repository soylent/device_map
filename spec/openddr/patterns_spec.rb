require 'device_map'

RSpec.describe DeviceMap::OpenDDR::Patterns do
  let(:keyword) { 'keyword' }

  let(:pattern) do
    DeviceMap::Pattern.new(keyword, 'device_id', 1)
  end

  # FIXME: Bad specs
  describe '.parse' do
    it 'returns instance of patterns class' do
      builder_stub = double(:builder, patterns: Array(pattern))
      expect(DeviceMap::OpenDDR::Builder).to receive(:find) { builder_stub }

      openddr_builder = Nokogiri::XML::Builder.new do |xml|
        xml.ODDR do
          xml.Builders do
            xml.builder do
              xml.device do
                xml.list do
                  xml.value_ 'test'
                end
              end
            end
          end
        end
      end

      patterns = described_class.parse(openddr_builder.to_xml)

      expect(patterns).to be_a(described_class)
      expect(patterns.find(keyword)).to include pattern
    end
  end

  describe '#find' do
    it 'returns list of patterns for the given keyword' do
      patterns = described_class.new(Array(pattern))
      search_results = patterns.find(keyword)

      expect(search_results).to include pattern
    end

    it 'returns empty list if keyword is not found' do
      all_patterns = []
      patterns = described_class.new(all_patterns)
      devices = patterns.find('anything')
      expect(devices).to be_empty
    end
  end
end
