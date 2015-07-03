# frozen_string_literal: true

require 'device_map'

RSpec.describe DeviceMap::UserAgent do
  describe '#keyword_ngrams' do
    example do
      user_agent = described_class.new('iphone')
      ngrams = user_agent.keyword_ngrams(1)

      expect(ngrams.size).to eq 1
      expect(ngrams).to include %w[iphone]
    end

    example do
      user_agent = described_class.new('iPhone; U')
      ngrams = user_agent.keyword_ngrams(2)

      expect(ngrams.size).to eq 3
      expect(ngrams).to include %w[iphone]
      expect(ngrams).to include %w[iphone u]
      expect(ngrams).to include %w[u]
    end

    example do
      user_agent = described_class.new('Mozilla/5.0')
      ngrams = user_agent.keyword_ngrams(3)

      expect(ngrams.size).to eq 3
      expect(ngrams).to include %w[mozilla]
      expect(ngrams).to include %w[mozilla 50]
      expect(ngrams).to include %w[50]
    end

    example do
      user_agent = described_class.new('Mozilla/5.0 (iPhone)')
      ngrams = user_agent.keyword_ngrams(3)

      expect(ngrams.size).to eq 6
      expect(ngrams).to include %w[mozilla]
      expect(ngrams).to include %w[mozilla 50]
      expect(ngrams).to include %w[mozilla 50 iphone]
      expect(ngrams).to include %w[50]
      expect(ngrams).to include %w[50 iphone]
      expect(ngrams).to include %w[iphone]
    end
  end
end
