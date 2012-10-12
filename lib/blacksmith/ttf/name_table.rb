class Blacksmith::TTF::NameTable < Blacksmith::TTF::Table
	
	unsigned_short :format
	unsigned_short :count
	unsigned_short :string_offset
	
	property :name_records, :default => lambda { Array.new }
	
	def <<(name_record)
		name_records << name_record
	end
	
end