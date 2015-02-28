module DeviceMap
  module Properties
    Property = Struct.new(:name, :type_name, :source_name) do
      TYPE_MAPPING = {
        integer: Types::Integer,
        boolean: Types::Boolean,
        string:  Types::String
      }

      def cast(value)
        return if value.nil?

        type = TYPE_MAPPING.fetch(type_name)
        type.cast(value)
      end
    end
  end
end
