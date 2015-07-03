# frozen_string_literal: true

require 'device_map'

RSpec.describe DeviceMap::Keyword do
  describe '.normalize' do
    it 'strips all non-alphanumeric characters' do
      normalized_keywords = described_class.normalize ['test-123', 'test_123']
      expect(normalized_keywords).to eq %w[test123 test123]
    end

    it 'convers all characters to lower case' do
      normalized_keywords = described_class.normalize %w[Test TEST]
      expect(normalized_keywords).to eq %w[test test]
    end

    example do
      normalized_keywords = described_class.normalize ['[Bb]lack.?[Bb]erry']
      expect(normalized_keywords).to eq ['blackberry']
    end
  end

  describe '.join' do
    example do
      joined_keywords = described_class.join %w[test 123]
      expect(joined_keywords).to eq 'test123'
    end

    example do
      joined_keywords = described_class.join %w[test test123]
      expect(joined_keywords).to eq 'test123'
    end
  end
end
