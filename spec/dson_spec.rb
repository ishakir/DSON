# -*- encoding : utf-8 -*-
require 'DSON'

PUNCTUATION_MATCH = '(,|\.|!|\\?)'
AND_MATCH = '(and|also)'

describe 'DSON simple hash handling' do

  it 'should be correct with an empty hash' do
    dson_hash = Hash.new
    dson_string = DSON.such_serialize_wow(dson_hash)

    expect(dson_string).to eq(
      'such wow'
    )
  end

  it 'should be correct with a hash with one element' do
    dson_hash = {
      dson: 'awesome'
    }
    dson_string = DSON.such_serialize_wow(dson_hash)

    expect(dson_string).to eq(
      'such "dson" is "awesome" wow'
    )
  end

  it 'should be correct with a hash with two elements' do
    dson_or_ruby = '("dson" is "awesome"|"ruby" is "great")'

    dson_hash = {
      dson: 'awesome',
      ruby: 'great'
    }
    dson_string = DSON.such_serialize_wow(dson_hash)

    expect(dson_string).to match(
      /such #{dson_or_ruby}#{PUNCTUATION_MATCH} #{dson_or_ruby} wow/
    )
  end

  it 'should be correct with a hash with three elements' do
    dson_ruby_or_dogescript =
      '(' \
        '"dson" is "awesome"' \
      '|' \
        '"ruby" is "great"' \
      '|' \
        '"dogescript" is "fine"' \
      ')'

    dson_hash = {
      dson: 'awesome',
      ruby: 'great',
      dogescript: 'fine'
    }
    dson_string = DSON.such_serialize_wow(dson_hash)

    regex_string =
      'such' \
      ' ' +
      dson_ruby_or_dogescript +
      PUNCTUATION_MATCH +
      ' ' +
      dson_ruby_or_dogescript +
      PUNCTUATION_MATCH +
      ' ' +
      dson_ruby_or_dogescript +
      ' ' +
      'wow'

    expect(dson_string).to match(
      /#{regex_string}/
    )
  end

end

describe 'DSON simple array handling' do

  it 'should correctly handle an empty array' do
    dson_array = Array.new
    dson_string = DSON.such_serialize_wow(dson_array)

    expect(dson_string).to eq(
      'so many'
    )
  end

  it 'should correctly handle an array with a single element' do
    dson_array = %w(cheese)
    dson_string = DSON.such_serialize_wow(dson_array)

    expect(dson_string).to eq(
      'so "cheese" many'
    )
  end

  it 'should correctly handle an array with two elements' do
    dson_array = %w(cheese wine)
    dson_string = DSON.such_serialize_wow(dson_array)

    expect(dson_string).to match(
      /so "cheese" #{AND_MATCH} "wine" many/
    )
  end

  it 'should correctly handle an array with three elements' do
    dson_array = %w(cheese wine bread)
    dson_string = DSON.such_serialize_wow(dson_array)

    expect(dson_string).to match(
      /so "cheese" #{AND_MATCH} "wine" #{AND_MATCH} "bread" many/
    )
  end

  it "dayo" do
    puts DSON.such_serialize_wow({
      ruby: 'pure',
      supports: [
        'hash',
        'array'
      ]
    })
  end

end
