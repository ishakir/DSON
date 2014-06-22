# -*- encoding : utf-8 -*-
require 'DSON'

require_relative 'lib/example_class'

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

  it 'should handle an object with an empty array element' do
    dson_hash = {
      array: []
    }
    dson_string = DSON.such_serialize_wow(dson_hash)

    expect(dson_string).to eq(
      'such "array" is so many wow'
    )
  end

  it 'should handle an object with an array element' do
    dson_hash = {
      array: %w(olive grape)
    }
    dson_string = DSON.such_serialize_wow(dson_hash)

    expect(dson_string).to match(
      /such "array" is so "olive" #{AND_MATCH} "grape" many wow/
    )
  end

  it 'should handle an array with an object element' do
    dson_array = [
      {
        first_name: 'Cyril',
        surname: 'Figgis'
      }
    ]
    dson_string = DSON.such_serialize_wow(dson_array)

    first_or_last_name = '("first_name" is "Cyril"|"surname" is "Figgis")'

    expect(dson_string).to match(
      /so such #{first_or_last_name}#{PUNCTUATION_MATCH} #{first_or_last_name} wow many/
    )
  end

end

describe 'DSON empty' do

  it 'translates a nil object to empty' do
    dson_hash = {
      value: nil
    }
    dson_string = DSON.such_serialize_wow(dson_hash)

    expect(dson_string).to eq(
      'such "value" is empty wow'
    )
  end

end

describe 'DSON booleans' do

  it 'translates a true object to yes' do
    dson_hash = {
      value: true
    }
    dson_string = DSON.such_serialize_wow(dson_hash)

    expect(dson_string).to eq(
      'such "value" is yes wow'
    )
  end

  it 'translates a false object to no' do
    dson_hash = {
      value: false
    }
    dson_string = DSON.such_serialize_wow(dson_hash)

    expect(dson_string).to eq(
      'such "value" is no wow'
    )
  end

end

describe 'ruby objects' do

  it 'translates a trivial class instance to DSON' do
    ruby_object = DSONSpec::TrivialClass.new
    dson_string = DSON.such_serialize_wow(ruby_object)

    expect(dson_string).to eq('such wow')
  end

  it 'translates an example class instance to DSON' do
    ruby_object = DSONSpec::ExampleClass.new('awesome', 'superb')
    dson_string = DSON.such_serialize_wow(ruby_object)

    real_or_imaginary = '("name" is "awesome"|"value" is "superb")'

    expect(dson_string).to match(
      /such #{real_or_imaginary}#{PUNCTUATION_MATCH} #{real_or_imaginary} wow/
    )
  end

end

# TODO fix when we can do octals generically
# describe "DSON numbers" do

#   it "doesn't quote numeric values" do
#     dson_hash = {
#       value: 13
#     }
#     dson_string = DSON.such_serialize_wow(dson_hash)

#     expect(dson_string).to eq(
#       'such "value" is 13 wow'
#     )
#   end

#   it "quotes numeric values represented as strings" do
#     dson_hash = {
#       value: "13"
#     }
#     dson_string = DSON.such_serialize_wow(dson_hash)

#     expect(dson_string).to eq(
#       'such "value" is "13" wow'
#     )
#   end

#   it "quotes float values" do
#     dson_hash = {
#       value: 12.5
#     }
#     dson_string = DSON.such_serialize_wow(dson_hash)

#     expect(dson_string).to eq(
#       'such "value" is 12.5 wow'
#     )
#   end

# end
