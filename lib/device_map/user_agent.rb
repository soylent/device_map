module DeviceMap
  class UserAgent
    def initialize(user_agent)
      @user_agent = user_agent
    end

    def keywords
      @user_agent.downcase.split(/[\s;\/\(\)]+/)
    end
  end
end
