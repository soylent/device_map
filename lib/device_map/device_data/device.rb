# frozen_string_literal: true

module DeviceMap
  module DeviceData
    # Device
    class Device
      include Properties::DSL

      # @!attribute [r] ajax_manipulate_css
      #   @return [Boolean]
      property :ajax_manipulate_css, type: :boolean

      # @!attribute [r] ajax_manipulate_dom
      #   @return [Boolean]
      property :ajax_manipulate_dom, type: :boolean

      # @!attribute [r] ajax_support_event_listener
      #   @return [Boolean]
      property :ajax_support_event_listener, type: :boolean

      # @!attribute [r] ajax_support_events
      #   @return [Boolean]
      property :ajax_support_events, type: :boolean

      # @!attribute [r] ajax_support_getelementbyid
      #   @return [Boolean]
      property :ajax_support_getelementbyid, type: :boolean

      # @!attribute [r] ajax_support_inner_html
      #   @return [Boolean]
      property :ajax_support_inner_html, type: :boolean

      # @!attribute [r] ajax_support_javascript
      #   @return [Boolean]
      property :ajax_support_javascript, type: :boolean

      # @!attribute [r] device_os
      #   @return [String]
      property :device_os, type: :string

      # @!attribute [r] device_os_version
      #   @return [String]
      property :device_os_version, type: :string

      # @!attribute [r] display_height
      #   @return [Integer]
      property :display_height, type: :integer, source_name: :displayHeight

      # @!attribute [r] display_width
      #   @return [Integer]
      property :display_width, type: :integer, source_name: :displayWidth

      # @!attribute [r] dual_orientation
      #   @return [Boolean]
      property :dual_orientation, type: :boolean

      # @!attribute [r] from
      #   @return [String]
      property :from, type: :string

      # @!attribute [r] id
      #   @return [String]
      property :id, type: :string

      # @!attribute [r] image_inlining
      #   @return [Boolean]
      property :image_inlining, type: :boolean

      # @!attribute [r] input_devices
      #   @return [String]
      property :input_devices, type: :string, source_name: :inputDevices

      # @!attribute [r] is_bot
      #   @return [Boolean]
      property :is_bot, type: :boolean

      # @!attribute [r] is_desktop
      #   @return [Boolean]
      property :is_desktop, type: :boolean

      # @!attribute [r] is_tablet
      #   @return [Boolean]
      property :is_tablet, type: :boolean

      # @!attribute [r] is_wireless_device
      #   @return [Boolean]
      property :is_wireless_device, type: :boolean

      # @!attribute [r] marketing_name
      #   @return [String]
      property :marketing_name, type: :string

      # @!attribute [r] mobile_browser
      #   @return [String]
      property :mobile_browser, type: :string

      # @!attribute [r] mobile_browser_version
      #   @return [String]
      property :mobile_browser_version, type: :string

      # @!attribute [r] model
      #   @return [String]
      property :model, type: :string

      # @!attribute [r] nokia_edition
      #   @return [String]
      property :nokia_edition, type: :string

      # @!attribute [r] nokia_series
      #   @return [String]
      property :nokia_series, type: :string

      # @!attribute [r] pixel_density_ppi
      #   @return [Integer]
      property :pixel_density_ppi, type: :integer

      # @!attribute [r] release_year
      #   @return [Integer]
      property :release_year, type: :integer, source_name: :'release-year'

      # @!attribute [r] vendor
      #   @return [String]
      property :vendor, type: :string

      # @!attribute [r] xhtml_format_as_attribute
      #   @return [Boolean]
      property :xhtml_format_as_attribute, type: :boolean

      # @!attribute [r] xhtml_format_as_css_property
      #   @return [Boolean]
      property :xhtml_format_as_css_property, type: :boolean

      UNKNOWN_ID = 'unknown'
      private_constant :UNKNOWN_ID

      # Creates a devices from a given device node
      #
      # @param device_node [Nokogiri::XML::Element] device node
      # @return [DeviceMap::DeviceData::Device]
      def self.parse(device_node)
        properties = device_node.xpath('property')
        attrs = properties.each_with_object({}) do |property, result|
          result[property[:name]] = property[:value]
        end

        new(attrs.merge(id: device_node[:id]))
      end

      # Returns an unknown device
      #
      # @return [DeviceMap::DeviceData::Device]
      def self.unknown
        new(id: UNKNOWN_ID)
      end
    end
  end
end
