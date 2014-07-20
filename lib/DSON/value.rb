# -*- encoding : utf-8 -*-
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
      return NumericValue.new(value) if value.is_a? Integer or value.is_a? Float
      return StringValue.new(value)  if value.is_a? String
      ObjectValue.new(value)
    end

    def self.so_parse(dson_string)
      handle_next(
        word_array: dson_string.scan(/(?:"(?:\\.|[^"])*"|[^" ,!\.\?])+/),
      )
    end

    def self.handle_next(options)
      word_array = options[:word_array]

      fail 'An error has occurred, this could be either user error or a bug. Please check your DSON is valid, and if it is, please raise a GitHub issue' if word_array.empty?

      first_word = word_array.shift

      if first_word == 'such'
        return HashValue.so_parse(
          word_array: word_array,
          parent_hash: {}
        )
      end
      if first_word == 'so'
        return ArrayValue.so_parse(
          word_array: word_array,
          parent_array: []
        )
      end
      return TrueValue.so_parse           if first_word == 'yes'
      return FalseValue.so_parse          if first_word == 'no'
      return NilValue.so_parse            if first_word == 'empty'

      StringValue.so_parse(first_word)
    end

    # Class methods can't be accessed from subclasses if protected...
    # Find better way if possible
    def self.remove_first_and_last_words(string)
      non_whitespace_elements = string.split(' ')
      non_whitespace_elements.pop
      non_whitespace_elements.shift
      non_whitespace_elements.join(' ')
    end

    def self.remove_first_and_last_elements(array)
      array.pop
      array.shift
    end

    protected

    def self.remove_all_strings(dson_string)
      string_hash = {}
      replaced_string = dson_string.gsub(/"(.*?)"/).with_index do |match, index|
        string_hash[index] = match[1..-2]
        index
      end
      [string_hash, replaced_string]
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
