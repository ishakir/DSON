# -*- encoding : utf-8 -*-
require 'DSON/value'

module DSON
  module Value
    class StringValue
      include Value

      attr_reader :value

      def self.so_parse(string)
        string[1..-2]
      end

      def initialize(value)
        @value = value
      end

      def such_serialize_wow
        "\"#{value}\""
      end
    end
  end
end
