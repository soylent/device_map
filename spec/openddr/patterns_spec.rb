require 'device_map'

RSpec.describe DeviceMap::OpenDDR::Patterns do
  def builder_stub(keyword, device_id)
    pattern = DeviceMap::Pattern.new(keyword, device_id, 1)
    double(patterns: Array(pattern))
  end

  # FIXME: Bad specs
  describe '.parse' do
    before do
      expect(DeviceMap::OpenDDR::Builder).to receive(:find) do
        builder_stub('anything', 'anything')
      end
    end

    it 'retuns instance of patterns class' do
      openddr_builder = Nokogiri::XML::Builder.new do |xml|
        xml.ODDR do
          xml.Builders do
            xml.builder
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
      builders = Array(builder_stub(keyword, device_id))
      patterns = described_class.new(builders)

      search_results = patterns.find(keyword)
      expect(search_results).not_to be_empty
      search_results.each do |pattern|
        expect(pattern.device_id).to eq device_id
        expect(pattern.keywords).to include keyword
      end
    end

    it 'returns empty list if keyword is not found' do
      builders = []
      patterns = described_class.new(builders)
      devices = patterns.find('anything')
      expect(devices).to be_empty
    end
  end
end
