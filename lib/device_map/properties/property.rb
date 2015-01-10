module DeviceMap
  module Properties
    class Property < Struct.new(:name, :type_name, :attr_name)
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
