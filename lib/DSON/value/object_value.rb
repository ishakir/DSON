# -*- encoding : utf-8 -*-
require 'DSON/value'

module DSON
  module Value
    class ObjectValue
      include Value

      attr_reader :value

      def initialize(value)
        @value = value
      end

      def such_serialize_wow
        # Construct a hash of the instance variables
        object_hash = Hash[
          value.instance_variables.map do |variable|
            [
              remove_at_from_attribute_name(variable),
              value.instance_variable_get(variable)
            ]
          end
        ]

        value = DSON::Value.new(object_hash)
        value.such_serialize_wow
      end

      private

      def remove_at_from_attribute_name(attribute_name)
        attribute_name[1..-1]
      end
    end
  end
end
