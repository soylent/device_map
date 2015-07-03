# frozen_string_literal: true

module DeviceMap
  module Properties
    # Property types
    module Types
      # Integer property type
      module Integer
        # Converts a given value to integer
        #
        # @param value [#to_i] value
        # @return [Integer]
        def self.cast(value)
          value.to_i
        end
      end

      # Boolean property type
      module Boolean
        # Converts a given string to boolean
        #
        # @raise [ArgumentError] if the value is not `true` or `false`
        # @param value [String] value
        # @return [Boolean]
        def self.cast(value)
          case value
          when 'true' then true
          when 'false' then false
          else raise ArgumentError, "Cannot cast #{value} to boolean"
          end
        end
      end

      # String property type
      module String
        # Converts a given value to string
        #
        # @param value [#to_s] value
        # @return [String] string
        def self.cast(value)
          value.to_s
        end
      end
    end
  end
end
