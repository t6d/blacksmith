require 'spec_helper'

describe Blacksmith::Runner do


  describe '#generate' do

  end

  describe '#version' do
    let(:output) { capture(:stdout) { subject.version } }

    specify { output.should eq("Blacksmith v#{Blacksmith::VERSION}\n") }
  end
  
  describe "#init" do
    
    before { capture(:stdout) { subject.init('myfont') } }
    
    it 'should create a build directory' do
      File.directory?('myfont/build').should be_true
    end
    
    it 'should create a source directory' do
      File.directory?('myfont/source').should be_true
    end
    
    it 'should create a Forgefile' do
      File.read('myfont/Forgefile').should eq("family 'myfont'\n")
    end
  end
  
end