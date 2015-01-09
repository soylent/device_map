require 'device_map'

RSpec.describe DeviceMap::OpenDDR::Patterns do
  # FIXME: Bad specs
  describe '.parse' do
    it 'retuns instance of patterns class' do
      pattern = DeviceMap::Pattern.new('anything', 'anything', 1)
      builder_stub = double(:builder, patterns: Array(pattern))

      expect(DeviceMap::OpenDDR::Builder).to receive(:find) do
        builder_stub
      end

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
    end
  end

  describe '#find' do
    it 'returns list of patterns for the given keyword' do
      device_id, keyword = 'iphone', 'ios'
      pattern = DeviceMap::Pattern.new(keyword, device_id, 1)

      patterns = described_class.new(Array(pattern))
      search_results = patterns.find(keyword)

      expect(search_results).not_to be_empty

      search_results.each do |pattern|
        expect(pattern.device_id).to eq device_id
        expect(pattern.keywords).to include keyword
      end
    end

    it 'returns empty list if keyword is not found' do
      all_patterns = []
      patterns = described_class.new(all_patterns)
      devices = patterns.find('anything')
      expect(devices).to be_empty
    end
  end
end
