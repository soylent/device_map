# frozen_string_literal: true

require 'singleton'

module DeviceMap
  # User agent classifier
  #
  # @api private
  class Classifier
    include Singleton

    KEYWORD_NGRAM_SIZE = 4
    private_constant :KEYWORD_NGRAM_SIZE

    # @return [DeviceMap::DeviceData::Patterns] user agent classification
    #   patterns
    attr_reader :patterns

    # @return [DeviceMap::DeviceData::Devices] device database
    attr_reader :devices

    def initialize
      @patterns = Marshal.load(File.open(PATTERNS_DUMP))
      @devices = Marshal.load(File.open(DEVICES_DUMP))
    end

    # Classifies a given user agent
    #
    # @param user_agent [String] user agent string
    # @return [DeviceMap::DeviceData::Device] detected device
    def find_device(user_agent)
      user_agent = UserAgent.new(user_agent)
      keyword_ngrams = user_agent.keyword_ngrams(KEYWORD_NGRAM_SIZE)

      search_hits = keyword_ngrams.each_with_object(Set.new) do |ngram, hits|
        hits.merge patterns.find(ngram.join)
      end

      matched_pattern = search_hits.sort.reverse.find do |pattern|
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
