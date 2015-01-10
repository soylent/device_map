require 'singleton'

module DeviceMap
  class Classifier
    include Singleton

    KEYWORD_NGRAM_SIZE = 4

    BUILDER_DATA_SOURCE = File.join(RESOURCES_PATH, 'BuilderDataSource.xml')
    DEVICE_DATA_SOURCE = File.join(RESOURCES_PATH, 'DeviceDataSource.xml')

    attr_reader :patterns, :devices

    def initialize
      @patterns = DeviceData::Patterns.parse(File.open(BUILDER_DATA_SOURCE))
      @devices = DeviceData::Devices.parse(File.open(DEVICE_DATA_SOURCE))
    end

    # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
    def find_device(ua)
      user_agent = UserAgent.new(ua)
      keyword_ngrams = user_agent.keyword_ngrams(KEYWORD_NGRAM_SIZE)

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
        DeviceData::Device.unknown
      end
    end
  end
end
