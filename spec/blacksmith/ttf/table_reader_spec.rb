require 'spec_helper'

describe Blacksmith::TTF::TableReader do
  
  let(:os2_table)  { mock(:os_table).as_null_object }
  let(:head_table) { mock(:head_table).as_null_object }
  let(:name_table) { mock(:name_table).as_null_object }
  let(:raw_table)  { mock(:raw_table).as_null_object }
  
  subject do
    described_class.new do |tag|
      case tag
      when 'OS/2' then o2_table
      when 'head' then head_table
      when 'name' then name_table
      else
        raw_table
      end
    end
  end
  
  context "when reading a standard (raw) table" do
    
    let(:tag)  { 'zzzz' }
    let(:data) { "\x00\x01" }
    
    it "should set the correct tag" do
      raw_table.should_receive(:tag=).with(tag)
    end
    
    it "should set the correct data" do
      raw_table.should_receive(:data=).with(data)
    end
    
    after do
      subject.read(tag, data)
    end
    
  end
  
  context "when reading the head table of the fixture blacksmith" do
    
    fixture = TTFFixture['blacksmith']
    tag     = 'head'
    
    fixture[tag].members.each do |m, v|
      
      it "should set #{m} correctly" do
        head_table.should_receive("#{m}=").with(v)
      end
      
    end
    
    after do
      subject.read(tag, fixture[tag].data)
    end
    
  end
  
end