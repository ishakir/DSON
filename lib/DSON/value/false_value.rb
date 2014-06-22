require 'DSON/value'

require 'singleton'

module DSON
  module Value
    class FalseValue
      include Value
      include Singleton

      def self.so_parse
        false
      end

      def such_serialize_wow
        'no'
      end
    end
  end
end
