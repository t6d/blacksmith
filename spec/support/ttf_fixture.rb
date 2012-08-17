require 'stringio'

class TTFFixture
  
  class Table
    
    include Enumerable
    
    attr_accessor :data
    
    def initialize
      @members = {}
    end
    
    def members
      @members.dup
    end
    
    def each(&block)
      @members.each(&block)
    end
    
    def method_missing(m, *args, &block)
      m = m.to_s
      
      if args.length == 1 && match = /(.+)=$/.match(m)
        @members[match.captures[0]] = args[0]
      elsif args.length == 0 && @_members.include?(m)
        @members[m]
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
  f.table('OS/2', 280, 96)
  f.table('cmap', 376, 322)
  f.table('cvt ', 1636, 16)
  f.table('fpgm', 1652, 2301)
  f.table('gasp', 1628, 8)
  f.table('glyf', 700, 166)
  f.table('head', 868, 54) do |t|
    t.major_version = 1
    t.minor_version = 0
  end
  f.table('hhea', 924, 36)
  f.table('hmtx', 960, 16)
  f.table('loca', 976, 10)
  f.table('maxp', 988, 32)
  f.table('name', 1020, 561)
  f.table('post', 1584, 42)
  f.table('prep', 3956, 45)
end

RSpec.configure do |config|
  
  config.after(:each) do
    TTFFixture.reset!
  end
  
end