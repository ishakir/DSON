# -*- encoding : utf-8 -*-
require 'DSON/value'

module DSON
  module Value
    class StringValue
      include Value

      attr_reader :value

      def self.so_parse(options)
        numeric_identifier = options[:first_word]
        options[:string_hash][numeric_identifier.to_i]
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
