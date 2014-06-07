module DSON
  class ArrayValue
    POTENTIAL_JOINERS = %w(and also)

    attr_reader :value

    def initialize(value)
      @value = value
    end

    def such_serialize_wow
      content = values.reduce('') do |array_entry|

      end
    end
  end
end
