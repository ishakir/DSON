require 'DSON/value'

require 'singleton'

module DSON
  module Value
    class NilValue
      include Value
      include Singleton

      def such_serialize_wow
        'empty'
      end
    end
  end
end
