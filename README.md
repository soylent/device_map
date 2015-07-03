# DeviceMap

Apache DeviceMap is a project to create a data repository containing device
information, images and other relevant information for all sorts of mobile
devices, e.g. smartphones and tablets.

[Apache DeviceMap](http://devicemap.apache.org/)

[![Build Status](https://travis-ci.org/soylent/device_map.svg?branch=master)](https://travis-ci.org/soylent/device_map)
[![Code Climate](https://codeclimate.com/github/soylent/device_map/badges/gpa.svg)](https://codeclimate.com/github/soylent/device_map)

## Installation

Add `device_map` to your `Gemfile` and execute `bundle install`.

## Example

```ruby
require 'device_map'

user_agent =
  'Mozilla/5.0 (Linux; U; Android 4.2.2; En-us; SM-T312 Build/JDQ39) ' \
  'AppleWebKit/534.30 (KHTML, Like Gecko) Version/4.0 Safari/534.30'

device = DeviceMap.classify(user_agent)

device.ajax_manipulate_css         # => true
device.ajax_manipulate_dom         # => true
device.ajax_support_event_listener # => true
device.ajax_support_events         # => true
device.ajax_support_getelementbyid # => true
device.ajax_support_inner_html     # => true
device.ajax_support_javascript     # => true
device.device_os                   # => "Android"
device.device_os_version           # => "2.3"
device.display_height              # => 800
device.display_width               # => 480
device.dual_orientation            # => true
device.from                        # => "open_db_modified"
device.id                          # => "GT-I9100"
device.image_inlining              # => true
device.input_devices               # => "touchscreen"
device.marketing_name              # => "Galaxy S II"
device.mobile_browser              # => "Android Webkit"
device.mobile_browser_version      # => "4.0"
device.model                       # => "GT-I9100"
```

## Contributing

Pull requests are very welcome!

Please make sure that your changes don't break the tests by running:

```sh
$ bundle exec rake
```
