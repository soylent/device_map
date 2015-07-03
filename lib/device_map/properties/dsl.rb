# frozen_string_literal: true

module DeviceMap
  module Properties
    # Raises when an unknown device property is set
    class UnknownProperty < StandardError; end

    # DSL to define device properties
    module DSL
      # Device DSL methods
      module ClassMethods
        # Define a device property
        #
        # @param name [Symbol] property name
        # @param type [Symbol] property type
        # @param source_name [Symbol] source property name
        # @return [void]
        def property(name, type: :string, source_name: name)
          attr_reader name
          properties[source_name] = Property.new(name, type, source_name)
        end

        # Returns a list of defined properties
        #
        # @return [Array<DeviceMap::Properties::Property>]
        def properties
          @properties ||= {}
        end
      end

      def self.included(base) # :nodoc:
        base.extend(ClassMethods)
      end

      # @param attrs [Array<#to_sym>] list of property names
      def initialize(attrs)
        attrs.each do |name, value|
          property = properties.fetch(name.to_sym) do
            raise UnknownProperty, "Property #{name} is not defined"
          end

          attr_name = property.name
          casted_value = property.cast(value)
          instance_variable_set(:"@#{attr_name}", casted_value)
        end
      end

      # Returns true if self and other have the same properties
      #
      # @param other [DeviceMap::Properties::DSL] other instance
      # @return [Boolean]
      def ==(other)
        properties.all? do |_, property|
          attr_name = property.name
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
