require "DSON/version"

module DSON
  
	POTENTIAL_PUNCTUATION = %w(, . ! ?)

	def self.such_serialize_wow(subject)
		return "such #{members(subject)}wow"
	end

	private

	def self.members(subject)
		subject.keys.each.with_index.reduce("") do |string, (key, index)|
			content = "#{key} is #{subject[key]}"
			punctuation = POTENTIAL_PUNCTUATION[rand(4)]
			whitespace = " "

			potential_string = (index == subject.keys.size - 1) ? content : content + punctuation
			string + potential_string + whitespace

		end 
	end

end