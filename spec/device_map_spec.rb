require 'device_map'

RSpec.describe DeviceMap do
  describe '.classify' do
    it 'returns device' do
      device = described_class.classify('iPhone')
      expect(device).to be_a(DeviceMap::Device)
    end
  end
end
