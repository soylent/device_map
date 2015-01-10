module DeviceMap
  module Properties
    module Types
      module Integer
        def self.cast(value)
          value.to_i
        end
      end

      module Boolean
        def self.cast(value)
          case value
          when 'true' then true
          when 'false' then false
          else fail ArgumentError, "Cannot cast #{value} to boolean"
          end
        end
      end

      module String
        def self.cast(value)
          value.to_s
        end
      end
    end
  end
end
