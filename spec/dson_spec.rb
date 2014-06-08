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

end

describe 'DSON nested arrays' do

  it 'should correctly handle empty nested arrays' do
    dson_array = [[]]
    dson_string = DSON.such_serialize_wow(dson_array)

    expect(dson_string).to eq(
      'so so many many'
    )
  end

  it 'should correctly handle nested arrays with elements' do
    dson_array = ['cheese', []]
    dson_string = DSON.such_serialize_wow(dson_array)

    expect(dson_string).to match(
      /so "cheese" #{AND_MATCH} so many many/
    )
  end

  it 'should correctly handle a nested array with an element' do
    dson_array = [['cheese']]
    dson_string = DSON.such_serialize_wow(dson_array)

    expect(dson_string).to eq(
      'so so "cheese" many many'
    )
  end

  it 'should correctly handle a more complex nested array' do
    dson_array = ['cheese', ['cheese', ['cheese']]]
    dson_string = DSON.such_serialize_wow(dson_array)

    expect(dson_string).to match(
      /so "cheese" #{AND_MATCH} so "cheese" #{AND_MATCH} so "cheese" many many many/
    )
  end

end

describe 'DSON nested hashes' do

  it 'should handle a simple nested hash' do
    dson_hash = {
      nested: {}
    }
    dson_string = DSON.such_serialize_wow(dson_hash)

    expect(dson_string).to eq(
      'such "nested" is such wow wow'
    )
  end

  it 'should handle a further nested hash' do
    dson_hash = {
      nested: {
        further_nested: {
        }
      }
    }
    dson_string = DSON.such_serialize_wow(dson_hash)

    expect(dson_string).to eq(
      'such "nested" is such "further_nested" is such wow wow wow'
    )
  end

  it 'should handle other elements in this hash' do
    dson_hash = {
      other: 'true',
      nested: {
      }
    }
    dson_string = DSON.such_serialize_wow(dson_hash)

    other_or_nested = '("other" is "true"|"nested" is such wow)'

    expect(dson_string).to match(
      /such #{other_or_nested}#{PUNCTUATION_MATCH} #{other_or_nested} wow/
    )
  end

  it 'should handle elements in a nested hash' do
    dson_hash = {
      other: 'true',
      nested: {
        element: 'great'
      }
    }
    dson_string = DSON.such_serialize_wow(dson_hash)

    other_or_nested = '("other" is "true"|"nested" is such "element" is "great" wow)'

    expect(dson_string).to match(
      /such #{other_or_nested}#{PUNCTUATION_MATCH} #{other_or_nested} wow/
    )
  end

  it 'should handle multiple elements in the nested hash' do
    dson_hash = {
      wine: {
        white: 'great',
        red: 'greater'
      }
    }
    dson_string = DSON.such_serialize_wow(dson_hash)

    white_or_red = '("white" is "great"|"red" is "greater")'

    expect(dson_string).to match(
      /such "wine" is such #{white_or_red}#{PUNCTUATION_MATCH} #{white_or_red} wow wow/
    )
  end

end

describe 'DSON hash and array mixes' do

  it 'should handle an array of empty objects' do
    dson_array = [
      {}, {}
    ]
    dson_string = DSON.such_serialize_wow(dson_array)

    expect(dson_string).to match(
      /so such wow #{AND_MATCH} such wow many/
    )
  end

end