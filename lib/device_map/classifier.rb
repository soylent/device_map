require 'singleton'

module DeviceMap
  class Classifier
    include Singleton

    KEYWORD_NGRAM_SIZE = 4

    attr_reader :patterns, :devices

    def initialize
      # TODO: Refactor
      @patterns = Marshal.load(File.open(PATTERNS_DUMP))
      @devices = Marshal.load(File.open(DEVICES_DUMP))
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
