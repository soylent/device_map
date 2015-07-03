# frozen_string_literal: true

module DeviceMap
  # User agent pattern
  #
  # @api private
  class Pattern
    include Comparable

    # @return [Array<String>] pattern keywords
    attr_reader :keywords

    # @return [String] device id associated with the pattern
    attr_reader :device_id

    # @return [Comparable] pattern priority
    attr_reader :priority

    # @param keywords [Array<String>] user agent keywords
    # @param device_id [String] device id
    # @param priority [Comparable] device priority
    def initialize(keywords, device_id, priority)
      @keywords = Keyword.normalize(Array(keywords))
      @device_id = device_id
      @priority = priority
    end

    # Returns true if the pattern matches given keywords
    #
    # @param other_keywords [Array<String>] the keywords
    # @return [Boolean]
    def matches?(other_keywords)
      diff = keywords - other_keywords
      diff.empty?
    end

    # Compares self with other pattern
    #
    # @see Comparable
    # @param other [DeviceMap::Pattern] other pattern
    # @return [Integer]
    def <=>(other)
      if priority == other.priority
        keywords.join.size <=> other.keywords.join.size
      else
        priority <=> other.priority
      end
    end

    # Returns true if the pattern is equal to other pattern
    #
    # @param other [DeviceMap::Pattern] other pattern
    # @return [Boolean]
    def ==(other)
      keywords == other.keywords &&
        device_id == other.device_id &&
        priority == other.priority
    end
  end
end
