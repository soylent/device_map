require 'singleton'

module DeviceMap
  class Classifier
    include Singleton

    KEYWORD_NGRAM_SIZE = 4

    BUILDER_DATA_SOURCE = File.join(RESOURCES_PATH, 'BuilderDataSource.xml')
    DEVICE_DATA_SOURCE = File.join(RESOURCES_PATH, 'DeviceDataSource.xml')

    attr_reader :patterns, :devices

    def initialize
      @patterns = OpenDDR::Patterns.parse(File.open(BUILDER_DATA_SOURCE))
      @devices = OpenDDR::Devices.parse(File.open(DEVICE_DATA_SOURCE))
    end

    def find_device(ua)
      user_agent = UserAgent.new(ua)
      keyword_ngrams = user_agent.ngrams(KEYWORD_NGRAM_SIZE)

      search_hits = keyword_ngrams.each_with_object(Set.new) do |ngram, hits|
        hits.merge patterns.find(ngram.join)
      end

      matched_pattern = search_hits.sort.reverse.find do |pattern|
        # FIXME: Match only against keyword hits
        pattern.matches?(keyword_ngrams.map(&:join))
      end

      if matched_pattern
        devices.find(matched_pattern.device_id)
      else
        OpenDDR::Device.unknown
      end
    end
  end
end