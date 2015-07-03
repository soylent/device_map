# frozen_string_literal: true

module DeviceMap
  module DeviceData
    # Pattern builders
    module Builder
      # Raises when a builder for a given builder node class is not found
      class BuilderNotFound < StandardError; end

      # Find a builder for a given builder node class
      #
      # @raise [BuilderNotFound] if the builder is not found
      # @param builder_node_class [String] builder node class
      # @return [SIMPLE_BUILDER, GENERIC_BUILDER, TWO_STEP_BUILDER] builder
      def self.find(builder_node_class)
        builders.fetch(builder_node_class) do
          raise BuilderNotFound,
                "Could not find builder for #{builder_node_class}"
        end
      end

      # Associate a builder with a given builder node class
      #
      # @param klass [SIMPLE_BUILDER, GENERIC_BUILDER, TWO_STEP_BUILDER]
      #   builder
      # @param builder_class [String] builder node class
      # @return [void]
      def self.register(klass, builder_class)
        builders[builder_class] = klass
      end

      def self.builders
        @builders ||= {}
      end

      private_class_method :builders

      # Creates OR patterns
      Simple = Struct.new(:priority) do
        # @!attribute priority
        #   @return [Comparable] pattern priority

        # Returns a list of patterns for a given device and a list of keywords
        #
        # @param device_id [String] device id
        # @param keywords [Array<String>] list of keywords
        # @return [Array<DeviceMap::Pattern>] list of patterns
        def patterns(device_id, keywords)
          keywords.map do |keyword|
            Pattern.new(keyword, device_id, priority)
          end
        end
      end

      # Creates AND patterns
      TwoStep = Struct.new(:priority) do
        # @!attribute priority
        #   @return [Comparable] pattern priority

        # Returns a list of patterns for a given device and a list of keywords
        #
        # @param device_id [String] device id
        # @param keywords [Array<String>] list of keywords
        # @return [Array<DeviceMap::Pattern>] list of patterns
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

      # Creates OR patterns with low priority
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
