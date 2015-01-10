module DeviceMap
  module Properties
    class UnknownProperty < StandardError; end

    module DSL
      module ClassMethods
        def property(name, type: :string, attr_name: name)
          attr_reader attr_name
          properties[name] = Property.new(name, type, attr_name)
        end

        # FIXME: This method should not be public
        def properties
          @properties ||= {}
        end
      end

      def self.included(base)
        base.extend(ClassMethods)
      end

      def initialize(attrs)
        attrs.each do |name, value|
          property = properties.fetch(name.to_sym) do
            fail UnknownProperty, "Property #{name} is not defined"
          end

          attr_name = property.attr_name
          casted_value = property.cast(value)
          instance_variable_set(:"@#{attr_name}", casted_value)
        end
      end

      def ==(other)
        properties.all? do |_, property|
          attr_name = property.attr_name
          public_send(attr_name) == other.public_send(attr_name)
        end
      end

      private

      def properties
        self.class.properties
      end
    end
  end
end
