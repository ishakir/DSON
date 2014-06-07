# -*- encoding : utf-8 -*-
module DSON
  module Value
    class ArrayValue
      include Value

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
    end
  end
end
