module DeviceMap
  class Pattern
    include Comparable

    attr_reader :keyword, :device_id, :priority

    def initialize(keyword, device_id, priority)
      @keyword = keyword
      @device_id = device_id
      @priority = priority
    end

    def <=>(other)
      if priority == other.priority
        keyword.size <=> other.keyword.size
      else
        priority <=> other.priority
      end
    end

    def ==(other)
      keyword == other.keyword &&
        device_id == other.device_id &&
        priority == other.priority
    end
  end
end
