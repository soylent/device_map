require 'device_map'

RSpec.describe DeviceMap::OpenDDR::Patterns do
  describe '#find' do
    it 'returns list of device ids for the given keyword' do
      device_id, keywords = 'iphone', %w(ios apple)

      openddr_builder_xml = generate_openddr_xml(
        builder_class: 'org.apache.devicemap.simpleddr.builder.device.DesktopOSDeviceBuilder',
        device_id: device_id,
        keywords: keywords
      )

      patterns = described_class.new(openddr_builder_xml.to_xml)

      keywords.each do |keyword|
        devices = patterns.find(keyword)
        expect(devices).to include device_id
      end
    end

    it 'asd' do
      device_id, keywords = 'iphone', %w(ios apple)

      openddr_builder_xml = generate_openddr_xml(
        builder_class: 'org.apache.devicemap.simpleddr.builder.device.TwoStepDeviceBuilder',
        device_id: device_id,
        keywords: keywords
      )

      patterns = described_class.new(openddr_builder_xml.to_xml)
      devices = patterns.find(keywords.join)

      expect(devices).to include device_id
    end

    it 'returns empty list if keyword is not found' do
      openddr_builder_xml = ''
      patterns = described_class.new(openddr_builder_xml)
      devices = patterns.find('anything')
      expect(devices).to be_empty
    end

    it 'raises exception if builder class is unknown' do
      openddr_builder_xml = generate_openddr_xml(
        builder_class: 'unknown',
        device_id: 'anything',
        keywords: ['anything']
      )

      expect do
        described_class.new(openddr_builder_xml.to_xml)
      end.to raise_error(DeviceMap::OpenDDR::Builder::BuilderNotFound)
    end
  end

  # rubocop:disable Metrics/MethodLength
  def generate_openddr_xml(builder_class:, device_id:, keywords:)
    Nokogiri::XML::Builder.new do |xml|
      xml.ODDR do
        xml.Builders do
          xml.builder(class: builder_class) do
            xml.device(id: device_id) do
              xml.list do
                keywords.each do |keyword|
                  xml.value_ keyword
                end
              end
            end
          end
        end
      end
    end
  end
end
