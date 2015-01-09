require 'device_map'

RSpec.describe DeviceMap::Pattern do
  let(:priority) { 1 }
  let(:higher_priority) { priority + 1 }

  let(:keyword) { 'keyword' }
  let(:longer_keyword) { 'longer_keyword' }

  let(:device_id) { 'device_id' }

  it 'is comparable by keyword size' do
    pattern1 = described_class.new(keyword, device_id, priority)
    pattern2 = described_class.new(longer_keyword, device_id, priority)

    expect(pattern1).to be < pattern2
  end

  it 'is comparable by priority' do
    pattern1 = described_class.new(keyword, device_id, higher_priority)
    pattern2 = described_class.new(longer_keyword, device_id, priority)

    expect(pattern1).to be > pattern2
  end

  it 'can be equal to other pattern' do
    pattern1 = described_class.new(keyword, device_id, priority)
    pattern2 = described_class.new(keyword, device_id, priority)

    expect(pattern1).to eq pattern2
  end

  describe '#matches?' do
    let(:pattern) do
      described_class.new(keyword, device_id, priority)
    end

    let(:other_keywords) { ['anything', 'else'] }

    it 'returns true if given keywords contain all pattern keywords' do
      given_keywords = other_keywords + pattern.keywords
      expect(pattern.matches?(given_keywords)).to eq true
    end

    it 'returns false if given keywords do not contain all pattern keywords' do
      expect(pattern.matches?(other_keywords)).to eq false
    end
  end
end
