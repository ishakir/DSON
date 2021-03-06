# -*- encoding : utf-8 -*-
require 'DSON/value'

require 'singleton'

module DSON
  module Value
    class TrueValue
      include Value
      include Singleton

      def self.so_parse
        true
      end

      def such_serialize_wow
        'yes'
      end
    end
  end
end
