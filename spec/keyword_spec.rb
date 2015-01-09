require 'device_map'

RSpec.describe DeviceMap::Keyword do
  describe '.normalize' do
    it 'strips all non-alphanumeric characters' do
      normalized_keywords = described_class.normalize ['test-123', 'test_123']
      expect(normalized_keywords).to eq ['test123', 'test123']
    end

    it 'convers all characters to lower case' do
      normalized_keywords = described_class.normalize ['Test', 'TEST']
      expect(normalized_keywords).to eq ['test', 'test']
    end

    example do
      normalized_keywords = described_class.normalize ['[Bb]lack.?[Bb]erry']
      expect(normalized_keywords).to eq ['blackberry']
    end
  end
end
