require 'device_map'

RSpec.describe DeviceMap::DeviceData::Devices do
  describe '#find' do
    it 'finds device by its id' do
      device_stub = double(id: 'device_id')
      devices = described_class.new(Array(device_stub))
      device = devices.find(device_stub.id)
      expect(device.id).to eq device_stub.id
    end

    it 'raises exception if device is not found' do
      devices = described_class.new([])
      expect do
        devices.find('anything')
      end.to raise_error(DeviceMap::DeviceData::Devices::DeviceNotFound)
    end
  end

  describe '.parse' do
    it 'returns new instance of this class' do
      devices_xml = generate_devices_xml.to_xml
      devices = described_class.parse(devices_xml)
      expect(devices).to be_a(described_class)
    end
  end

  def generate_devices_xml
    Nokogiri::XML::Builder.new do |xml|
      xml.ODDR do
        xml.Devices do
          xml.device
        end
      end
    end
  end
end
