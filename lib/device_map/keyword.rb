module DeviceMap
  module Keyword
    # Deletes all non-alphanumeric characters from the given keywords
    def self.normalize(keywords)
      keywords.map do |keyword|
        # HACK: <tt>BUILDER_DATA_SOURCE</tt> contains keywords like:
        #     <device id="BlackBerry 9650">
        #         <list>
        #             <value>[Bb]lack.?[Bb]erry</value>
        #             <value>blackberry 9650</value>
        #         </list>
        #     </device>
        # In such cases we want to replace patterns with simple keywords.
        keyword.downcase.gsub('[bb]', 'b').gsub(/[\W_]+/, '')
      end
    end
  end
end
