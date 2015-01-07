module DeviceMap
  module OpenDDR
    module Builder
      class BuilderNotFound < StandardError; end

      class << self
        def find(builder_node)
          builder_node_class = builder_node[:class]
          builder_class = builders.fetch(builder_node_class) do
            fail BuilderNotFound,
              "Could not find builder for #{builder_node_class}"
          end

          builder_class.new(builder_node)
        end

        def register(klass, builder_class)
          builders[builder_class] = klass
        end

        private

        def builders
          @builders ||= {}
        end
      end

      class Simple
        def initialize(builder_node)
          @builder_node = builder_node
        end

        def keywords_and_devices
          @builder_node.xpath('device').flat_map do |device_node|
            device_node.xpath('list/value').map do |keyword_node|
              # NOTE: Return list of <tt>Pattern</tt> instances
              # instead of tuples?
              [keyword_node.content, device_node[:id]]
            end
          end
        end
      end

      class TwoStep
        def initialize(builder_node)
          @builder_node = builder_node
        end

        def keywords_and_devices
          @builder_node.xpath('device').map do |device_node|
            keyword_nodes = device_node.xpath('list/value')
            [keyword_nodes.inner_text, device_node[:id]]
          end
        end
      end

      register Simple, 'org.apache.devicemap.simpleddr.builder.device.DesktopOSDeviceBuilder'
      register Simple, 'org.apache.devicemap.simpleddr.builder.device.SimpleDeviceBuilder'
      register Simple, 'org.apache.devicemap.simpleddr.builder.device.BotDeviceBuilder'
      register Simple, 'org.apache.devicemap.simpleddr.builder.device.AndroidDeviceBuilder'
      register Simple, 'org.apache.devicemap.simpleddr.builder.device.SymbianDeviceBuilder'
      register Simple, 'org.apache.devicemap.simpleddr.builder.device.WinPhoneDeviceBuilder'
      register Simple, 'org.apache.devicemap.simpleddr.builder.device.IOSDeviceBuilder'
      register TwoStep, 'org.apache.devicemap.simpleddr.builder.device.TwoStepDeviceBuilder'
    end
  end
end
