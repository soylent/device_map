module DeviceMap
  module Keyword
    def self.normalize(keyword)
      # FIXME: Problem with the blackberry keywords in the XML files
      keyword.downcase.tr('[bb]', 'b').gsub(/\W+/, '')
    end
  end
end
