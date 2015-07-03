# frozen_string_literal: true

module DeviceMap
  # Device properties
  module Properties
    TYPE_MAPPING = {
      integer: Types::Integer,
      boolean: Types::Boolean,
      string:  Types::String
    }.freeze

    private_constant :TYPE_MAPPING

    # Property type
    Property = Struct.new(:name, :type_name, :source_name) do
      # Converts a given value to appropriate type
      #
      # @param value [Object] original value
      # @return [Object] converted value
      def cast(value)
        return if value.nil?

        type = TYPE_MAPPING.fetch(type_name)
        type.cast(value)
      end
    end
  end
end
