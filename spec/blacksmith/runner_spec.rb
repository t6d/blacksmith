require 'spec_helper'

describe Blacksmith::Runner do


  describe '#generate' do

  end

  describe '#version' do
    let(:output) { capture(:stdout) { subject.version } }

    specify { output.should eq("Blacksmith v#{Blacksmith::VERSION}\n") }
  end
end