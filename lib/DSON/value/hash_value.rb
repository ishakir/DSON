# -*- encoding : utf-8 -*-
require 'DSON/value'

module DSON
  module Value
    class HashValue
      include Value

      def self.so_parse(options)
        word_array = options[:word_array]
        parent_hash = options[:parent_hash]

        if word_array[0] == 'wow'
          word_array.shift
          return parent_hash
        end
        word_array.shift unless (word_array[0] =~ (/\?|\.|,|!/)).nil?

        string_hash = options[:string_hash]

        # The next value will be a key
        numeric_key = word_array.shift
        key = string_hash[numeric_key.to_i]

        # remove is
        word_array.shift

        value = DSON::Value.handle_next(options)
        parent_hash[key] = value

        so_parse(options)
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

      def self.parse_pair(string, acc_hash)
        results = string.scan(/"(.*)" is (.*)/)
        acc_hash[results[0][0]] = DSON::Value.so_parse(results[0][1])
        acc_hash
      end
    end
  end
end
