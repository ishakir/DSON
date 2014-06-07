require 'DSON'

describe DSON do
	 PUNCTUATION_MATCH = '(,|.|!|\\?)'

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
 		 puts DSON.such_serialize_wow(dson: 'awesome', ruby: 'great', dogescript: 'fine')
 	end

end
