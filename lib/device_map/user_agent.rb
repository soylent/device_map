module DeviceMap
  class UserAgent
    def initialize(user_agent)
      @user_agent = user_agent
    end

    def ngrams(size)
      keywords = @user_agent.split(/[\s;\-_\/()\[\]\\]+/).map do |keyword|
        Keyword.normalize(keyword)
      end

      keywords.flat_map.with_index do |keyword, i|
        size.times.map do |j|
          next_keywords = keywords[i + 1..-1] || []
          Array(keyword).concat next_keywords.take(j)
        end
      end.uniq
    end
  end
end
