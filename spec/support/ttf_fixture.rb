require 'stringio'

class TTFFixture
  
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
    
    fixture = new(path).tap(&block)
    fixture.data = begin
      io = StringIO.new(File.read(path))
      io.rewind
      io
    end
    
    self[File.basename(path, '.ttf')] = fixture
    
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
  
end

RSpec.configure do |config|
  
  config.after(:each) do
    TTFFixture.reset!
  end
  
end