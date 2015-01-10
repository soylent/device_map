module DeviceMap
  class UserAgent
    def initialize(user_agent)
      @user_agent = user_agent
    end

    def keyword_ngrams(size)
      keywords = @user_agent.split(/[\s;\-_\/()\[\]\\]+/)
      normalized_keywords = Keyword.normalize(keywords)

      normalized_keywords.flat_map.with_index do |keyword, i|
        size.times.map do |j|
          next_keywords = normalized_keywords[i + 1..-1] || []
          Array(keyword).concat next_keywords.take(j)
        end
      end.uniq
    end
  end
end
