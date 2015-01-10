require 'device_map'

RSpec.describe DeviceMap::Classifier do
  describe '#find_device' do
    let(:user_agent) { 'test' }

    let(:classifier) do
      described_class.instance
    end

    let(:device) do
      DeviceMap::DeviceData::Device.new(id: 'device_id')
    end

    context 'when device is found' do
      before do
        pattern = DeviceMap::Pattern.new(user_agent, device.id, 1)
        expect(classifier.patterns).to receive(:find) do
          Set.new [pattern]
        end
      end

      it 'returns device object' do
        expect(classifier.devices).to receive(:find).with(device.id) { device }

        found_device = classifier.find_device(user_agent)
        expect(found_device).to eq device
      end
    end

    context 'when device is not found' do
      before do
        expect(classifier.patterns).to receive(:find) do
          Set.new
        end
      end

      it 'returns unknown device object' do
        found_device = classifier.find_device(user_agent)
        expect(found_device).to eq DeviceMap::DeviceData::Device.unknown
      end
    end
  end
end
