require 'DSON/value/hash_value'
require 'DSON/value/array_value'
require 'DSON/value/variable_value'

module DSON
  module Value
    SPACE = %q( )

    def reduce(list, potential_joiners)
      list.each.with_index.reduce('') do |acc, (element, index)|
        is_last = (index == list.size - 1)

        potential_string = is_last ? element : element + potential_joiners.sample
        acc + potential_string + SPACE
      end
    end
  end
end
