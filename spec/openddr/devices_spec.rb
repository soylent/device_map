require 'device_map'

RSpec.describe DeviceMap::OpenDDR::Devices do
  describe '#find' do
    it 'finds device by its id' do
      device_id = 'device_id'
      devices_doc = generate_devices(device_id)
      devices = described_class.new(devices_doc.to_xml)
      device = devices.find(device_id)
      expect(device.id).to eq device_id
    end
  end

  def generate_devices(device_id)
    Nokogiri::XML::Builder.new do |xml|
      xml.ODDR do
        xml.Devices do
          xml.device(id: device_id)
        end
      end
    end
  end
end
