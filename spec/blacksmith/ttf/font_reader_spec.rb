require 'spec_helper'

describe Blacksmith::TTF::FontReader do
  
  let(:font) { mock(:ttf_font).as_null_object }
  
  let(:table) { stub('table').as_null_object }
  let(:table_reader) { stub(:table_reader, :read => table) }
  
  subject { described_class.new(font) }
  
  before do
    Blacksmith::TTF::TableReader.stub(:new).and_return(table_reader)
  end
  
  context "when processing the fixture blacksmith" do
    
    fixture = TTFFixture['blacksmith']
    
    it "should set the correct major version" do
      font.should_receive(:major_version=).with(fixture.major_version)
    end
    
    it "should set the correct minor version" do
      font.should_receive(:minor_version=).with(fixture.minor_version)
    end
    
    it "should set the correct search range" do
      font.should_receive(:search_range=).with(fixture.search_range)
    end
    
    it "should set the correct entry selector" do
      font.should_receive(:entry_selector=).with(fixture.entry_selector)
    end
    
    it "should set the correct range shift" do
      font.should_receive(:range_shift=).with(fixture.range_shift)
    end
    
    it "should parse all tables" do
      font.should_receive(:<<).with(table).exactly(fixture.tables_count).times
    end
    
    fixture.each do |tag, table_data|
      it "should read the #{tag} table" do
        table_reader.should_receive(:read).with(tag, table_data)
      end
    end
    
    after do
      subject.read(fixture.data)
    end
    
  end

end