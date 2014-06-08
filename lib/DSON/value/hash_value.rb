# -*- encoding : utf-8 -*-
require 'DSON/value'

module DSON
  module Value
    class HashValue
      include Value

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
    end
  end
end
