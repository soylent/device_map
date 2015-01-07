require 'device_map'

RSpec.describe DeviceMap::Pattern do
  it 'is comparable by keyword size' do
    pattern1 = described_class.new('keyword', 'device1', 1)
    pattern2 = described_class.new('long_keyword', 'device2', 1)

    patterns = [pattern1, pattern2]

    expect(patterns.max).to eq pattern2
  end

  it 'is comparable by priority' do
    pattern1 = described_class.new('long_keyword', 'device1', 1)
    pattern2 = described_class.new('keyword', 'device2', 2)

    patterns = [pattern1, pattern2]

    expect(patterns.max).to eq pattern2
  end

  it 'can be equal to other pattern' do
    pattern1 = described_class.new('keyword', 'device', 1)
    pattern2 = described_class.new('keyword', 'device', 1)

    expect(pattern1).to eq pattern2
  end
end
