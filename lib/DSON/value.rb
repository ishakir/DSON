# -*- encoding : utf-8 -*-
require 'DSON/value/hash_value'
require 'DSON/value/array_value'
require 'DSON/value/string_value'
require 'DSON/value/nil_value'
require 'DSON/value/true_value'
require 'DSON/value/false_value'
require 'DSON/value/numeric_value'
require 'DSON/value/object_value'

module DSON
  module Value
    SPACE = %q( )

    def self.new(value)
      return HashValue.new(value)    if value.respond_to? :keys
      return ArrayValue.new(value)   if value.respond_to? :each
      return NilValue.instance       if value.nil?
      return TrueValue.instance      if value.is_a? TrueClass
      return FalseValue.instance     if value.is_a? FalseClass
      # return NumericValue.new(value) if value.is_a? Fixnum
      return StringValue.new(value)  if value.is_a? String
      ObjectValue.new(value)
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
