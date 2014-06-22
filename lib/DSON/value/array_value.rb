# -*- encoding : utf-8 -*-
require 'DSON/value'

module DSON
  module Value
    class ArrayValue
      include Value

      def self.so_parse(string)
        reduced_string = DSON::Value.remove_first_and_last_words(string)

        value_strings = reduced_string.split(AND_ALSO_REGEX, 0)

        value_strings.reduce(Array.new) do |array, result|
          parse_value(result, array)
        end
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

      private

      AND_ALSO_REGEX = / and | also /

      def self.parse_value(value, acc_array)
        acc_array.push DSON.so_parse(value)
      end
    end
  end
end
