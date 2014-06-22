require 'DSON/value'

require 'singleton'

module DSON
  module Value
    class TrueValue
      include Value
      include Singleton

      def such_serialize_wow
        'yes'
      end
    end
  end
end
