module DeviceMap
  module DeviceData
    class Device
      include Properties::DSL

      property :ajax_manipulate_css, type: :boolean
      property :ajax_manipulate_dom, type: :boolean
      property :ajax_support_event_listener, type: :boolean
      property :ajax_support_events, type: :boolean
      property :ajax_support_getelementbyid, type: :boolean
      property :ajax_support_inner_html, type: :boolean
      property :ajax_support_javascript, type: :boolean
      property :device_os, type: :string
      property :device_os_version, type: :string
      property :displayHeight, type: :integer, attr_name: :display_height
      property :displayWidth, type: :integer, attr_name: :display_width
      property :dual_orientation, type: :boolean
      property :from, type: :string
      property :id, type: :string
      property :image_inlining, type: :boolean
      property :inputDevices, type: :string, attr_name: :input_devices
      property :is_bot, type: :boolean
      property :is_desktop, type: :boolean
      property :is_tablet, type: :boolean
      property :is_wireless_device, type: :boolean
      property :marketing_name, type: :string
      property :mobile_browser, type: :string
      property :mobile_browser_version, type: :string
      property :model, type: :string
      property :nokia_edition, type: :string
      property :nokia_series, type: :string
      property :vendor, type: :string
      property :xhtml_format_as_attribute, type: :boolean
      property :xhtml_format_as_css_property, type: :boolean

      UNKNOWN_ID = 'unknown'

      def self.parse(device_node)
        properties = device_node.xpath('property')
        attrs = properties.each_with_object({}) do |property, result|
          result[property[:name]] = property[:value]
        end

        new(attrs.merge(id: device_node[:id]))
      end

      def self.unknown
        new(id: UNKNOWN_ID)
      end
    end
  end
end
