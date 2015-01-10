module DeviceMap
  module DeviceData
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

      # Creates OR patterns with normal priority
      SIMPLE_BUILDER = Simple.new(1)

      # Creates OR patterns with lower priority
      GENERIC_BUILDER = Simple.new(0)

      # Creates AND patterns with normal priority
      TWO_STEP_BUILDER = TwoStep.new(1)

      # rubocop:disable Metrics/LineLength

      register SIMPLE_BUILDER,   'org.apache.devicemap.simpleddr.builder.device.DesktopOSDeviceBuilder'
      register GENERIC_BUILDER,  'org.apache.devicemap.simpleddr.builder.device.SimpleDeviceBuilder'
      register SIMPLE_BUILDER,   'org.apache.devicemap.simpleddr.builder.device.BotDeviceBuilder'
      register SIMPLE_BUILDER,   'org.apache.devicemap.simpleddr.builder.device.AndroidDeviceBuilder'
      register SIMPLE_BUILDER,   'org.apache.devicemap.simpleddr.builder.device.SymbianDeviceBuilder'
      register SIMPLE_BUILDER,   'org.apache.devicemap.simpleddr.builder.device.WinPhoneDeviceBuilder'
      register SIMPLE_BUILDER,   'org.apache.devicemap.simpleddr.builder.device.IOSDeviceBuilder'
      register TWO_STEP_BUILDER, 'org.apache.devicemap.simpleddr.builder.device.TwoStepDeviceBuilder'

      # rubocop:enable Metrics/LineLength
    end
  end
end
