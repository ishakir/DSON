# -*- encoding : utf-8 -*-
require 'DSON/version'
require 'DSON/value'

module DSON
  def self.such_serialize_wow(subject)
    DSON::Value.new(subject).such_serialize_wow
  end

  def self.so_parse(string)
    DSON::Value.so_parse(string)
  end
end
