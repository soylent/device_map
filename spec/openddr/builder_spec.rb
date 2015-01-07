require 'device_map'

RSpec.describe DeviceMap::OpenDDR::Builder do
  describe '.find' do
    let(:builder_node_class) { 'fake_builder' }

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
      builder_node = generate_builder_node(builder_node_class)
      builder = described_class.find(builder_node)
      expect(builder).to be_a(fake_builder_class)
    end

    it 'raises exception if builder node class is unknown' do
      builder_node = generate_builder_node('unknown_class')
      expect do
        described_class.find(builder_node)
      end.to raise_error(DeviceMap::OpenDDR::Builder::BuilderNotFound)
    end
  end

  def generate_builder_node(builder_node_class)
    xml_builder = Nokogiri::XML::Builder.new do |xml|
      xml.builder(class: builder_node_class)
    end

    xml_builder.doc.child
  end
end
