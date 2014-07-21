# -*- encoding : utf-8 -*-
require 'DSON/value'

module DSON
  module Value
    class StringValue
      include Value

      attr_reader :value

      def self.so_parse(value)
        start_index = value.index('"') + 1
        end_index = value.rindex('"') - 1
        value[start_index..end_index]
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
