require 'device_map'

RSpec.describe DeviceMap do
  describe '.classify' do
    it 'returns device' do
      device = described_class.classify('android')
      expect(device).to be_a(DeviceMap::OpenDDR::Device)
    end
  end
end
