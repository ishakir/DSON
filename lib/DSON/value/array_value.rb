# -*- encoding : utf-8 -*-
require 'DSON/value'

module DSON
  module Value
    class ArrayValue
      include Value

      def self.so_parse(options)
        word_array = options[:word_array]
        parent_array = options[:parent_array]

        if word_array[0] == 'many'
          word_array.shift
          return parent_array
        end
        word_array.shift unless (word_array[0] =~ /^(and|also)$/).nil?

        # the next value will be the value
        parent_array.push(DSON::Value.handle_next(options))

        return parent_array if word_array.empty?

        so_parse(options)
      end

      POTENTIAL_JOINERS = [' and' , ' also']

      attr_reader :value

      def initialize(value)
        @value = value
      end

      def such_serialize_wow
        content = value.map do |arr_elem|
          Value.new(arr_elem).such_serialize_wow
        end
        'so ' + reduce(content, POTENTIAL_JOINERS) + 'many'
      end

      AND_ALSO_REGEX = / and | also /

      def self.parse_value(value, acc_array)
        acc_array.push DSON.so_parse(value)
      end
    end
  end
end
