require 'DSON'

describe DSON do 

	it "should be correct with an empty hash" do
		expect("such wow").to eq(DSON.such_serialization_wow(Hash.new))
	end
	
end