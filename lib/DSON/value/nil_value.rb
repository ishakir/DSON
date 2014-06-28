# -*- encoding : utf-8 -*-
require 'DSON/value'

require 'singleton'

module DSON
  module Value
    class NilValue
      include Value
      include Singleton

      def self.so_parse
        nil
      end

      def such_serialize_wow
        'empty'
      end
    end
  end
end
