require 'device_map'

RSpec.describe DeviceMap::UserAgent do
  describe '#keywords' do
    example do
      user_agent = described_class.new('iphone')
      expect(user_agent.keywords).to eq ['iphone']
    end

    example do
      user_agent = described_class.new('iPhone')
      expect(user_agent.keywords).to eq ['iphone']
    end

    example do
      user_agent = described_class.new('iPhone; U')
      expect(user_agent.keywords).to eq ['iphone', 'u']
    end

    example do
      user_agent = described_class.new('Mozilla/5.0')
      expect(user_agent.keywords).to eq ['mozilla', '5.0']
    end

    example do
      user_agent = described_class.new('Mozilla/5.0 (iPhone)')
      expect(user_agent.keywords).to eq ['mozilla', '5.0', 'iphone']
    end
  end
end
