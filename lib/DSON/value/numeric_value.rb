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

      def such_serialize_wow
        value.b(8).to_s
      end
    end
  end
end
