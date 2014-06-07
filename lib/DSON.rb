require 'DSON/version'
require 'DSON/value'

module DSON
	 def self.such_serialize_wow(subject)
 		 DSON::Value::HashValue.new(subject).such_serialize_wow
 	end
end
