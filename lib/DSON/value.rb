# -*- encoding : utf-8 -*-
require 'DSON/value/hash_value'
require 'DSON/value/array_value'
require 'DSON/value/variable_value'

module DSON
  module Value
    SPACE = %q( )

    def self.new(value)
      return HashValue.new(value) if value.respond_to?(:keys)
      return ArrayValue.new(value) if value.respond_to?(:each)
      VariableValue.new(value)
    end

    def reduce(list, potential_joiners)
      list.each_with_index.reduce('') do |acc, (element, index)|
        is_last = (index == list.size - 1)

        formed_string = is_last ? element : element + potential_joiners.sample
        acc + formed_string + SPACE
      end
    end
  end
end
