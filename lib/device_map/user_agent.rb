# frozen_string_literal: true

module DeviceMap
  # User agent
  #
  # @api private
  class UserAgent
    # @param user_agent [String] user agent
    def initialize(user_agent)
      @user_agent = user_agent
    end

    # Returns a list of n-grams up to a given size
    #
    # @param size [Integer] max n-gram size
    # @return [Array<Array<String>>>] n-grams
    def keyword_ngrams(size)
      keywords = @user_agent.split(%r{[\s;\-_\/()\[\]\\]+})
      normalized_keywords = Keyword.normalize(keywords)

      normalized_keywords.flat_map.with_index do |keyword, i|
        Array.new(size) do |j|
          next_keywords = normalized_keywords[i + 1..-1] || []
          Array(keyword).concat next_keywords.take(j)
        end
      end.uniq
    end
  end
end
