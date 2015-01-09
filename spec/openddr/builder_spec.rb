require 'device_map'

RSpec.describe DeviceMap::OpenDDR::Builder do
  let(:builder_node_class) { 'builder_node_class' }

  let(:device_id) { 'device_id' }
  let(:keywords) { ['keyword1', 'keyword2'] }

  def builder
    default_priority = 1
    described_class.new(default_priority)
  end

  describe '.find' do
    it 'returns builder object' do
      builder_stub = double(:builder)
      described_class.register(builder_stub, builder_node_class)

      builder = described_class.find(builder_node_class)

      expect(builder).to eq builder_stub
    end

    it 'raises exception if builder node class is unknown' do
      expect do
        described_class.find('unknown')
      end.to raise_error(DeviceMap::OpenDDR::Builder::BuilderNotFound)
    end
  end

  describe DeviceMap::OpenDDR::Builder::Simple do
    before do
      DeviceMap::OpenDDR::Builder.register(described_class, builder_node_class)
    end

    describe '#patterns' do
      it 'maps single pattern object to each device keyword' do
        patterns = builder.patterns(device_id, keywords)

        expect(patterns.size).to eq keywords.size
        pattern_keywords = patterns.flat_map(&:keywords)
        expect(pattern_keywords).to eq keywords
      end
    end
  end

  describe DeviceMap::OpenDDR::Builder::TwoStep do
    before do
      DeviceMap::OpenDDR::Builder.register(described_class, builder_node_class)
    end

    describe '#patterns' do
      it 'maps all device keywords to single pattern object' do
        patterns = builder.patterns(device_id, keywords)

        expect(patterns.size).to eq 2
        pattern_keywords = patterns.flat_map(&:keywords)
        expect(pattern_keywords).to include *keywords
        expect(pattern_keywords).to include keywords.join
      end
    end
  end
end
