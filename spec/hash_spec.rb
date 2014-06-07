# -*- encoding : utf-8 -*-
require 'DSON'

describe DSON do
  PUNCTUATION_MATCH = '(,|.|!|\\?)'
  AND_MATCH = '(and|also)'

  it 'should be correct with an empty hash' do
    expect(DSON.such_serialize_wow(Hash.new)).to eq('such wow')
 	end

  it 'should be correct with a hash with one element' do
    expect(DSON.such_serialize_wow(dson: 'awesome')).to eq('such "dson" is "awesome" wow')
 	end

  it 'should be correct with a hash with two elements' do
    dson_or_ruby = '("dson" is "awesome"|"ruby" is "great")'
    expect(DSON.such_serialize_wow(dson: 'awesome', ruby: 'great')).to match(/such #{dson_or_ruby}#{PUNCTUATION_MATCH} #{dson_or_ruby} wow/)
 	end

  it 'should be correct with a hash with three elements' do
        dson_ruby_or_dogescript = '("dson" is "awesome"|"ruby" is "great"|"dogescript" is "fine")'
        expect(DSON.such_serialize_wow(dson: 'awesome', ruby: 'great', dogescript: 'fine')).to match(/such #{dson_ruby_or_dogescript}#{PUNCTUATION_MATCH} #{dson_ruby_or_dogescript}#{PUNCTUATION_MATCH} #{dson_ruby_or_dogescript} wow/)
      end

  it 'should correctly handle an empty array' do
    expect(DSON.such_serialize_wow(Array.new)).to eq('so many')
  end

  it 'should correctly handle an array with a single element' do
    expect(DSON.such_serialize_wow(['hello'])).to eq('so "hello" many')
  end

  it 'should correctly handle an array with two elements' do
    expect(DSON.such_serialize_wow(%w(cheese wine))).to match(/so "cheese" #{AND_MATCH} "wine" many/)
  end

  it 'should correctly handle an array with three elements' do
    expect(DSON.such_serialize_wow(%w(cheese wine bread))).to match(/so "cheese" #{AND_MATCH} "wine" #{AND_MATCH} "bread" many/)
  end

end
