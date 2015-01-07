require 'device_map'

RSpec.describe DeviceMap::OpenDDR::Device do
  describe '.parse' do
    it 'returns new instance of this class' do
      properties = { id: 'iphone', vendor: 'Apple' }
      device_node = generate_device_node(properties)
      device = described_class.parse(device_node)

      expect(device.id).to eq properties.fetch(:id)
      expect(device.vendor).to eq properties.fetch(:vendor)
    end

    def generate_device_node(properties)
      builder = Nokogiri::XML::Builder.new do |xml|
        xml.device(id: properties.fetch(:id)) do
          properties.each do |name, value|
            xml.property(name: name, value: value)
          end
        end
      end

      builder.doc.child
    end
  end
end
