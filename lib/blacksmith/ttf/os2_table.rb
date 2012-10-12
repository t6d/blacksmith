class Blacksmith::TTF::OS2Table < Blacksmith::TTF::Table

	byte :major_version
	byte :minor_version
	unsigned_short :average_char_width
	unsigned_short :weight_class
	unsigned_short :width_class
	unsigned_short :fs_type
	unsigned_short :subscript_x_size
	unsigned_short :subscript_y_size
	unsigned_short :subscript_x_offset
	unsigned_short :subscript_y_offset
	unsigned_short :superscript_x_size
	unsigned_short :superscript_y_size
	unsigned_short :superscript_x_offset
	unsigned_short :superscript_y_offset
	unsigned_short :strikeout_size
	unsigned_short :strikeout_position
	unsigned_short :family_class
	property :panose, :accepts => Blacksmith::TTF::Panose
	unsigned_long :unicode_range_1
	unsigned_long :unicode_range_2
	unsigned_long :unicode_range_3
	unsigned_long :unicode_range_4
	unsigned_long :vendor_id
	unsigned_short :fs_selection
	unsigned_short :first_char_index
	unsigned_short :last_char_index
	unsigned_short :typo_ascender
	unsigned_short :typo_descender
	unsigned_short :typo_line_gap
	unsigned_short :win_ascent
	unsigned_short :win_descent
	unsigned_long :code_page_range_1
	unsigned_long :code_page_range_2
	unsigned_short :x_height
	unsigned_short :cap_height
	unsigned_short :default_char
	unsigned_short :break_char
	unsigned_short :max_context

end