# -*- encoding : utf-8 -*-
require 'DSON/value'

module DSON
  module Value
    class NumericValue
      include Value

      attr_reader :value

      def initialize(value)
        @value = value
      end

      def self.so_parse(value)
        if value.include?('very') || value.include?('VERY')
          parts = value.downcase.split('very')
          octal_string_to_numeric(parts[0]) * 8 ** octal_string_to_numeric(parts[1])
        else
          octal_string_to_numeric(value)
        end
      end

      def such_serialize_wow
        value.b(8).to_s
      end

      private

      def self.octal_string_to_numeric(value)
        value = value.b(8)
        if value.kind_of?(Radix::Float)
          value.to_f
        else
          value.to_i
        end
      end
    end
  end
end
