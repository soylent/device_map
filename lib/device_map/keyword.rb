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

    # Concatenate all keywords together and skip duplicates
    def self.join(keywords)
      # HACK: This function handles the case when we want to concatenate all
      # keywords without duplication.
      #     <device id="BlackBerry 9700">
      #         <list>
      #             <value>blackberry</value>
      #             <value>blackberry 9700</value>
      #         </list>
      #     </device>
      normalize(keywords).reduce('') do |result, keyword|
        if keyword.include?(result)
          keyword
        else
          result.concat(keyword)
        end
      end
    end
  end
end
