# -*- encoding : utf-8 -*-
module DSON
  class VariableValue
    attr_reader :value

    def initialize(value)
      @value = value
    end

    def such_serialize_wow
      "\"#{value}\""
    end
  end
end
