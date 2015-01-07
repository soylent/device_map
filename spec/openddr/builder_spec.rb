require 'device_map'

RSpec.describe DeviceMap::OpenDDR::Builder do
  let(:builder_node_class) { 'fake_builder' }

  describe '.find' do
    let(:fake_builder_class) do
      Class.new do
        def initialize(_); end
        def keywords_and_devices; [] end
      end
    end

    before do
      described_class.register(fake_builder_class, builder_node_class)
    end

    it 'returns builder object' do
      builder_node = generate_builder_node(builder_class: builder_node_class)
      builder = described_class.find(builder_node)
      expect(builder).to be_a(fake_builder_class)
    end

    it 'raises exception if builder node class is unknown' do
      builder_node = generate_builder_node(builder_class: 'unknown')
      expect do
        described_class.find(builder_node)
      end.to raise_error(DeviceMap::OpenDDR::Builder::BuilderNotFound)
    end
  end

  describe DeviceMap::OpenDDR::Builder::Simple do
    before do
      DeviceMap::OpenDDR::Builder.register(
        described_class, builder_node_class)
    end

    describe '#keywords_and_devices' do
      it 'maps each keyword to device id' do
        device_id, keywords = 'device', %w(keyword1 keyword2)

        builder_node = generate_builder_node(
          builder_class: builder_node_class,
          device_id: device_id,
          keywords: keywords
        )

        simple_builder = described_class.new(builder_node)
        expected_result = keywords.product(Array(device_id))
        expect(simple_builder.keywords_and_devices).to eq(expected_result)
      end
    end
  end

  describe DeviceMap::OpenDDR::Builder::TwoStep do
    before do
      DeviceMap::OpenDDR::Builder.register(
        described_class, builder_node_class)
    end

    describe '#keywords_and_devices' do
      it 'maps all keywords to the corresponding device id' do
        device_id, keywords = 'device', %w(keyword1 keyword2)

        builder_node = generate_builder_node(
          builder_class: builder_node_class,
          device_id: device_id,
          keywords: keywords
        )

        simple_builder = described_class.new(builder_node)
        expected_result = [keywords.join, device_id]
        expect(simple_builder.keywords_and_devices).to include(expected_result)
      end
    end
  end

  # rubocop:disable Metrics/MethodLength
  def generate_builder_node(builder_class:, device_id: 'anything', keywords: [])
    xml_builder = Nokogiri::XML::Builder.new do |xml|
      xml.builder(class: builder_class) do
        xml.device(id: device_id) do
          xml.list do
            keywords.each do |keyword|
              xml.value_ keyword
            end
          end
        end
      end
    end

    xml_builder.doc.child
  end
end
