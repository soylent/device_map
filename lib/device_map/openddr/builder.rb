module DeviceMap
  module OpenDDR
    module Builder
      class BuilderNotFound < StandardError; end

      class << self
        def find(builder_node_class)
          builders.fetch(builder_node_class) do
            fail BuilderNotFound,
              "Could not find builder for #{builder_node_class}"
          end
        end

        def register(klass, builder_class)
          builders[builder_class] = klass
        end

        private

        def builders
          @builders ||= {}
        end
      end

      class Simple < Struct.new(:priority)
        def patterns(device_id, keywords)
          keywords.map do |keyword|
            Pattern.new(keyword, device_id, priority)
          end
        end
      end

      class TwoStep < Struct.new(:priority)
        def patterns(device_id, keywords)
          joined_keywords = Keyword.join(keywords)

          [
            Pattern.new(keywords, device_id, priority),
            Pattern.new(joined_keywords, device_id, priority)
          ]
        end
      end

      register Simple.new(1),  'org.apache.devicemap.simpleddr.builder.device.DesktopOSDeviceBuilder'
      register Simple.new(0),  'org.apache.devicemap.simpleddr.builder.device.SimpleDeviceBuilder'
      register Simple.new(1),  'org.apache.devicemap.simpleddr.builder.device.BotDeviceBuilder'
      register Simple.new(1),  'org.apache.devicemap.simpleddr.builder.device.AndroidDeviceBuilder'
      register Simple.new(1),  'org.apache.devicemap.simpleddr.builder.device.SymbianDeviceBuilder'
      register Simple.new(1),  'org.apache.devicemap.simpleddr.builder.device.WinPhoneDeviceBuilder'
      register Simple.new(1),  'org.apache.devicemap.simpleddr.builder.device.IOSDeviceBuilder'
      register TwoStep.new(1), 'org.apache.devicemap.simpleddr.builder.device.TwoStepDeviceBuilder'
    end
  end
end
