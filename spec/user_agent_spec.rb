require 'device_map'

RSpec.describe DeviceMap::UserAgent do
  describe '#ngrams' do
    example do
      user_agent = described_class.new('iphone')
      ngrams = user_agent.ngrams(1)

      expect(ngrams.size).to eq 1
      expect(ngrams).to include ['iphone']
    end

    example do
      user_agent = described_class.new('iPhone; U')
      ngrams = user_agent.ngrams(2)

      expect(ngrams.size).to eq 3
      expect(ngrams).to include ['iphone']
      expect(ngrams).to include ['iphone', 'u']
      expect(ngrams).to include ['u']
    end

    example do
      user_agent = described_class.new('Mozilla/5.0')
      ngrams = user_agent.ngrams(3)

      expect(ngrams.size).to eq 3
      expect(ngrams).to include ['mozilla']
      expect(ngrams).to include ['mozilla', '5.0']
      expect(ngrams).to include ['5.0']
    end

    example do
      user_agent = described_class.new('Mozilla/5.0 (iPhone)')
      ngrams = user_agent.ngrams(2)

      expect(ngrams.size).to eq 6
      expect(ngrams).to include ['mozilla']
      expect(ngrams).to include ['mozilla', '5.0']
      expect(ngrams).to include ['mozilla', '5.0', 'iphone']
      expect(ngrams).to include ['5.0']
      expect(ngrams).to include ['5.0', 'iphone']
      expect(ngrams).to include ['iphone']
    end
  end
end
