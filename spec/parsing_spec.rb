# -*- encoding : utf-8 -*-
require 'DSON'

describe 'simple hashes' do

  it 'parses an empty DSON hash' do
    dson_string = 'such wow'
    parsed_dson = DSON.so_parse(dson_string)

    expect(parsed_dson.keys.size).to eq(0)
  end

  it 'parses a DSON hash with one element' do
    dson_string = 'such "dson" is "parsed" wow'
    parsed_dson = DSON.so_parse(dson_string)

    expect(parsed_dson['dson']).to eq('parsed')
  end

  it 'parses a DSON hash with two elements with , separator' do
    dson_string = 'such "dson" is "parsed", "language" is "ruby" wow'
    parsed_dson = DSON.so_parse(dson_string)

    expect(parsed_dson['dson']).to eq('parsed')
    expect(parsed_dson['language']).to eq('ruby')
  end

  it 'parses a DSON hash with two elements with . separator' do
    dson_string = 'such "dson" is "parsed". "language" is "ruby" wow'
    parsed_dson = DSON.so_parse(dson_string)

    expect(parsed_dson['dson']).to eq('parsed')
    expect(parsed_dson['language']).to eq('ruby')
  end

  it 'parses a DSON hash with two elements with ! separator' do
    dson_string = 'such "dson" is "parsed"! "language" is "ruby" wow'
    parsed_dson = DSON.so_parse(dson_string)

    expect(parsed_dson['dson']).to eq('parsed')
    expect(parsed_dson['language']).to eq('ruby')
  end

  it 'parses a DSON hash with two elements with ? separator' do
    dson_string = 'such "dson" is "parsed"? "language" is "ruby" wow'
    parsed_dson = DSON.so_parse(dson_string)

    expect(parsed_dson['dson']).to eq('parsed')
    expect(parsed_dson['language']).to eq('ruby')
  end

  it 'parses a DSON hash with three elements' do
    dson_string = 'such "dson" is "parsed"! "language" is "ruby". "separators" is "varied" wow'
    parsed_dson = DSON.so_parse(dson_string)

    expect(parsed_dson['dson']).to eq('parsed')
    expect(parsed_dson['language']).to eq('ruby')
    expect(parsed_dson['separators']).to eq('varied')
  end

end

describe 'parsing simple arrays' do

  it 'parses an empty DSON array' do
    dson_string = 'so many'
    parsed_dson = DSON.so_parse(dson_string)

    expect(parsed_dson.size).to eq(0)
  end

  it 'parses a DSON array with one element' do
    dson_string = 'so "test" many'
    parsed_dson = DSON.so_parse(dson_string)

    expect(parsed_dson[0]).to eq('test')
  end

  it 'parses a DSON array with two elements and "and" separator' do
    dson_string = 'so "test" and "quality" many'
    parsed_dson = DSON.so_parse(dson_string)

    expect(parsed_dson[0]).to eq('test')
    expect(parsed_dson[1]).to eq('quality')
  end

  it 'parses a DSON array with twp elements and "also" separator' do
    dson_string = 'so "test" also "quality" many'
    parsed_dson = DSON.so_parse(dson_string)

    expect(parsed_dson[0]).to eq('test')
    expect(parsed_dson[1]).to eq('quality')
  end

  it 'parses a DSON array with a mix of separators' do
    dson_string = 'so "test" also "quality" and "awesome" many'
    parsed_dson = DSON.so_parse(dson_string)

    expect(parsed_dson[0]).to eq('test')
    expect(parsed_dson[1]).to eq('quality')
    expect(parsed_dson[2]).to eq('awesome')
  end

  it 'parses an array with " and " and " also " in a value' do
    dson_string = 'so " and " also " also " and " and " many'
    parsed_dson = DSON.so_parse(dson_string)

    expect(parsed_dson[0]).to eq(' and ')
    expect(parsed_dson[1]).to eq(' also ')
    expect(parsed_dson[2]).to eq(' and ')
  end

end

describe 'parsing nested arrays' do

  it 'parses empty nested arrays' do
    dson_string = 'so so many many'
    parsed_dson = DSON.so_parse(dson_string)

    expect(parsed_dson.size).to eq(1)
    expect(parsed_dson[0].size).to eq(0)
  end

  it 'should correctly handle nested arrays with elements' do
    dson_string = 'so "cheese" also so many many'
    parsed_dson = DSON.so_parse(dson_string)

    expect(parsed_dson[0]).to eq('cheese')
    expect(parsed_dson[1].size).to eq(0)
  end

  it 'should correctly handle a nested array with an element' do
    dson_string = 'so so "cheese" many many'
    parsed_dson = DSON.so_parse(dson_string)

    expect(parsed_dson[0][0]).to eq('cheese')
  end

  it 'should correctly handle a more complex nested array' do
    dson_string = 'so "cheese" and so "cheese" also so "cheese" many many many'
    parsed_dson = DSON.so_parse(dson_string)

    expect(parsed_dson[0]).to eq('cheese')
    expect(parsed_dson[1][0]).to eq('cheese')
    expect(parsed_dson[1][1][0]).to eq('cheese')
  end

  it 'parses a hash with " is "" in one of the keys' do
    dson_string = 'such " is " is "cheese" wow'
    parsed_dson = DSON.so_parse(dson_string)

    expect(parsed_dson[' is ']).to eq('cheese')
  end

  it 'parses a hash with " is " in one of the values' do
    dson_string = 'such "cheese" is " is " wow'
    parsed_dson = DSON.so_parse(dson_string)

    expect(parsed_dson['cheese']).to eq(' is ')
  end

  it 'parses a hash with a comma in one of the keys' do
    dson_string = 'such "," is "cheese" wow'
    parsed_dson = DSON.so_parse(dson_string)

    expect(parsed_dson[',']).to eq('cheese')
  end

  it 'parses a hash with an exclaimation mark in one of the values' do
    dson_string = 'such "cheese" is "," wow'
    parsed_dson = DSON.so_parse(dson_string)

    expect(parsed_dson['cheese']).to eq(',')
  end

end

describe 'DSON nested hashes' do
  it 'should handle a simple nested hash' do
    dson_string = 'such "nested" is such wow wow'
    parsed_dson = DSON.so_parse(dson_string)

    expect(parsed_dson['nested'].keys.size).to eq(0)
  end

  it 'should handle a further nested hash' do
    dson_string = 'such "nested" is such "further_nested" is such wow wow wow'
    parsed_dson = DSON.so_parse(dson_string)

    expect(parsed_dson['nested']['further_nested'].keys.size).to eq(0)
  end

  it 'should handle other elements in this hash' do
    dson_string = 'such "other" is "true"! "nested" is such wow wow'
    parsed_dson = DSON.so_parse(dson_string)

    expect(parsed_dson['other']).to eq('true')
    expect(parsed_dson['nested'].keys.size).to eq(0)
  end

  it 'should handle elements in a nested hash' do
    dson_string = 'such "other" is "true". "nested" is such "element" is "great" wow wow'
    parsed_dson = DSON.so_parse(dson_string)

    expect(parsed_dson['other']).to eq('true')
    expect(parsed_dson['nested']['element']).to eq('great')
  end

  it 'should handle multiple elements in the nested hash' do
    dson_string = 'such "wine" is such "white" is "great"? "red" is "greater" wow wow'
    parsed_dson = DSON.so_parse(dson_string)

    expect(parsed_dson['wine']['white']).to eq('great')
    expect(parsed_dson['wine']['red']).to eq('greater')
  end
end

describe 'DSON hash and array mixes' do

  it 'should handle an array of empty objects' do
    dson_string = 'so such wow also such wow many'
    parsed_dson = DSON.so_parse(dson_string)

    expect(parsed_dson.size).to eq(2)
    expect(parsed_dson[0].keys.size).to eq(0)
    expect(parsed_dson[1].keys.size).to eq(0)
  end

  it 'should handle an object with an empty array element' do
    dson_string = 'such "array" is so many wow'
    parsed_dson = DSON.so_parse(dson_string)

    expect(parsed_dson['array'].size).to eq(0)
  end

  it 'should handle an object with an array element' do
    dson_string = 'such "array" is so "olive" also "grape" many wow'
    parsed_dson = DSON.so_parse(dson_string)

    expect(parsed_dson['array'][0]).to eq('olive')
    expect(parsed_dson['array'][1]).to eq('grape')
  end

  it 'should handle an array with an object element' do
    dson_string = 'so such "first_name" is "Cyril", "surname" is "Figgis" wow many'
    parsed_dson = DSON.so_parse(dson_string)

    expect(parsed_dson[0]['first_name']).to eq('Cyril')
    expect(parsed_dson[0]['surname']).to eq('Figgis')
  end

end

describe 'parsing DSON booleans' do
  it 'should translate yes in a hash to true' do
    dson_string = 'such "dson" is yes wow'
    parsed_dson = DSON.so_parse(dson_string)

    expect(parsed_dson['dson']).to be_a(TrueClass)
  end

  it 'should translate yes in an array to true' do
    dson_string = 'so yes many'
    parsed_dson = DSON.so_parse(dson_string)

    expect(parsed_dson[0]).to be_a(TrueClass)
  end

  it 'should translate no in a hash to false' do
    dson_string = 'such "json" is no wow'
    parsed_dson = DSON.so_parse(dson_string)

    expect(parsed_dson['json']).to be_a(FalseClass)
  end

  it 'should translate no in an array to false' do
    dson_string = 'so no many'
    parsed_dson = DSON.so_parse(dson_string)

    expect(parsed_dson[0]).to be_a(FalseClass)
  end
end

describe 'parsing DSON empty' do
  it 'should translate empty to nil' do
    dson_string = 'so empty many'
    parsed_dson = DSON.so_parse(dson_string)

    expect(parsed_dson[0]).to be_nil
  end
end
