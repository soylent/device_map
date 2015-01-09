module DeviceMap
  class Pattern
    include Comparable

    attr_reader :keywords, :device_id, :priority

    def initialize(keywords, device_id, priority)
      @keywords = Keyword.normalize(Array(keywords))
      @device_id = device_id
      @priority = priority
    end

    def matches?(other_keywords)
      diff = keywords - other_keywords
      diff.empty?
    end

    def <=>(other)
      if priority == other.priority
        keywords.join.size <=> other.keywords.join.size
      else
        priority <=> other.priority
      end
    end

    def ==(other)
      keywords == other.keywords &&
        device_id == other.device_id &&
        priority == other.priority
    end
  end
end
