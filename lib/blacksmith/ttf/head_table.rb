class Blacksmith::TTF::HeadTable < Blacksmith::TTF::Table
	
	byte :major_version
	byte :minor_version
	byte :major_font_revision
	byte :minor_font_revision
	unsigned_long :check_sum_adjustment
	unsigned_long :magic_number
	unsigned_short :flags
	unsigned_short :units_per_em
	long_long :created
	long_long :modified
	unsigned_short :x_min
	unsigned_short :x_max
	unsigned_short :y_min
	unsigned_short :y_max
	unsigned_short :mac_style
	unsigned_short :lowest_rect_ppem
	unsigned_short :font_direction_hint
	unsigned_short :index_to_loc_format
	unsigned_short :glyph_data_format
	
end