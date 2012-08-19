require 'stringio'

class TTFFixture
  
  class Table
    
    include Enumerable
    
    attr_accessor :data
    
    def initialize
      @members = {}
      @collections = {}
    end
    
    def each_member(&block)
      @members.each(&block)
    end
    
    def method_missing(m, *args, &block)
      m = m.to_s
      
      if args.length == 1 && match = /(.+)=$/.match(m)
        @members[match[1]] = args[0]
      elsif args.length > 0 && /.+[^=]$/.match(m)
        @collections[m] ||= []
        @collections[m] << args
      elsif args.length == 0 && @members.include?(m)
        @members[m]
      elsif args.length == 0 && match = /^each_(.+)/.match(m)
        if @collections.include?(match[1])
          @collections[match[1]].each(&block)
        else
          raise NoMethodError, "#{self.class}##{m} not defined"
        end
      else
        super
      end
    end
    
  end
  
  include Enumerable
  
  def self.[](name)
    @fixtures ||= {}
    @fixtures[name.to_sym]
  end
  
  def self.[]=(name, fixture)
    @fixtures ||= {}
    @fixtures[name.to_sym] = fixture
  end
  
  def self.describe(path, &block)
    path = File.expand_path("../../../fixtures/#{path}", __FILE__)
    
    fixture = new(StringIO.new(File.read(path)))
    fixture.tap(&block)
    
    self[File.basename(path, '.ttf')] = fixture
    
    fixture.reset!
    fixture
  end
  
  def self.reset!
    @fixtures.each { |_, f| f.reset! }
  end
  
  attr_accessor :data,
                :major_version,
                :minor_version,
                :tables_count,
                :search_range,
                :entry_selector,
                :range_shift
  
  def initialize(data)
    @data = data
    @tables = {}
  end
  
  def [](tag)
    @tables[tag]
  end
  
  def table(tag, offset, length, &block)
    old_pos = data.pos
    data.seek(offset, IO::SEEK_SET)
    @tables[tag] = begin
      table = Table.new
      table.data = data.read(length)
      table.tap(&block) if block
      table
    end
    data.seek(old_pos, IO::SEEK_SET)
    
    nil
  end
  
  def each(&block)
    @tables.each(&block)
  end
  
  def reset!
    @data.rewind
  end
  
end

TTFFixture.describe('blacksmith.ttf') do |f|
  f.major_version = 1
  f.minor_version = 0
  f.tables_count = 15
  f.search_range = 128
  f.entry_selector = 3
  f.range_shift = 112
  
  f.table('FFTM', 252, 28)
  f.table('OS/2', 280, 96) do |t|
    t.version = 4
    t.average_char_width = 975
    t.us_weight_class = 900
    t.us_width_class = 5
    t.fs_type = 0
    t.subscript_x_size = 650
    t.subscript_y_size = 700
    t.subscript_x_offset = 0
    t.subscript_y_offset = 140
    t.superscript_x_size = 650
    t.superscript_y_size = 700
    t.superscript_x_offset = 0
    t.superscript_y_offset = 480
    t.family_class = 49
    t.panose = Blacksmith::TTF::Panose.new(1, 2, 0, 0, 2, 0, 10, 9, 0, 0)
    t.unicode_range_1 = 0
    t.unicode_range_2 = 1
    t.unicode_range_3 = 0
    t.unicode_range_4 = 0
    t.vendor_id = "\x00" * 4
    t.fs_selection = 20582
    t.us_first_char_index = 17764
    t.us_last_char_index = 128
    t.typo_ascender = 97
    t.type_descender = 97
    t.type_line_gap = 800
    t.us_win_ascent = 65336
    t.us_win_descent = 90
    t.code_page_range_1 = 52428898
    t.code_page_range_2 = 1
  end
  f.table('cmap', 376, 322)
  f.table('cvt ', 1636, 16)
  f.table('fpgm', 1652, 2301)
  f.table('gasp', 1628, 8)
  f.table('glyf', 700, 166)
  f.table('head', 868, 54) do |t|
    t.major_version = 1
    t.minor_version = 0
    t.major_font_revision = 1
    t.minor_font_revision = 0
    t.check_sum = 0x8F53C37A
    t.magic_number = 0x5F0F3CF5
    t.flags = 0x000B
    t.units_per_em = 1000
    t.created = 3422346961
    t.modified = 3422346961
    t.x_min = 15
    t.y_min = -98
    t.x_max = 960
    t.y_max = 800
    t.mac_style = 0
    t.lowest_rec_ppem = 8
    t.font_direction_hint = 2
    t.index_to_loc_format = 0
    t.glyph_data_format = 0
  end
  f.table('hhea', 924, 36)
  f.table('hmtx', 960, 16)
  f.table('loca', 976, 10)
  f.table('maxp', 988, 32)
  f.table('name', 1020, 561) do |t|
    t.format = 0
    t.name_record(1, 0, 0, 1, 'Blacksmith')
    t.name_redord(1, 0, 2, 7, 'Regular')
  end
  f.table('post', 1584, 42)
  f.table('prep', 3956, 45)
end

RSpec.configure do |config|
  
  config.after(:each) do
    TTFFixture.reset!
  end
  
end