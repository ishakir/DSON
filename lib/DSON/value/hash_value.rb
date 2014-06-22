# -*- encoding : utf-8 -*-
require 'DSON/value'

module DSON
  module Value
    class HashValue
      include Value

      def self.so_parse(string)
        reduced_string = DSON::Value.remove_first_and_last_words(string)

        pair_strings = reduced_string.split /,|\.|!|\?/

        pair_strings.reduce(Hash.new) do |hash, result|
          parse_pair(result.strip, hash)
        end
      end

      POTENTIAL_PUNCTUATION = %w(, . ! ?)

      attr_reader :value

      def initialize(value)
        @value = value
      end

      def such_serialize_wow
        strings = value.keys.map do |key|
          key_str = StringValue.new(key).such_serialize_wow
          value_str = Value.new(value[key]).such_serialize_wow

          %Q(#{key_str} is #{value_str})
        end
        'such ' + reduce(strings, POTENTIAL_PUNCTUATION) + 'wow'
      end

      private

      def self.parse_pair(string, acc_hash)
        results = string.scan(/"(.*)" is (.*)/)
        acc_hash[results[0][0]] = DSON::Value.so_parse(results[0][1])
        acc_hash
      end
    end
  end
end
