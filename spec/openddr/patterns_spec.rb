require 'device_map'

RSpec.describe DeviceMap::OpenDDR::Patterns do
  def builder_stub(keyword, device_id)
    double(keywords_and_devices: [[keyword, device_id]])
  end

  describe '#find' do
    it 'returns list of device ids for the given keyword' do
      device_id, keyword = 'iphone', 'ios'
      builder = builder_stub(keyword, device_id)
      patterns = described_class.new(builder)

      expect(patterns.find(keyword)).to include device_id
    end

    it 'returns empty list if keyword is not found' do
      patterns = described_class.new
      devices = patterns.find('anything')
      expect(devices).to be_empty
    end
  end
end
