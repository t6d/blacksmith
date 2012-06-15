require 'spec_helper'

describe Blacksmith::Glyph do

  before { File.stub(:exist? => true) }

  let(:properties) do
    {
      :code => 1,
      :source => 'source.svg'
    }
  end

  subject { described_class.new(properties) }

  it { should have_property(:name) }
  it { should have_property(:code) }
  it { should have_property(:source) }
  it { should have_property(:left_side_bearing) }
  it { should have_property(:right_side_bearing) }
  it { should have_property(:scale) }
  it { should have_property(:offset) }

  its(:left_side_bearing) { should eq(15) }
  its(:right_side_bearing) { should eq(15) }

  describe '#name' do
    context 'no name is given' do
      before { properties.delete(:name) }

      it 'should derive the name from the source' do
        subject.name.should eq('source')
      end
    end
  end

  describe '#source=' do
    context 'when file exists' do
      it 'should not raise an error' do
        expect { subject.source = 'exists.svg' }.to_not raise_error ArgumentError
      end
    end

    context 'when file does not exist' do
      before { File.stub(:exist? => false) }

      it 'should raise an error' do
        expect { subject.source = 'missing.svg' }.to raise_error ArgumentError
      end
    end
  end

  describe '#scale=' do
    context 'when value is greater than zero' do
      it 'should not raise an error' do
        expect { subject.scale = 0.00001 }.to_not raise_error ArgumentError
      end    
    end
  
    context 'when value is zero' do
      it 'should raise an error' do
        expect { subject.scale = 0.0 }.to raise_error ArgumentError
      end    
    end
  end

  describe '#offset=' do
    context 'when value is -1.0' do
      it 'should not raise an error' do
        expect { subject.offset = -1.0 }.to_not raise_error ArgumentError
      end
    end

    context 'when value is greater than -1.0' do
      it 'should not raise an error' do
        expect { subject.offset = -0.9999 }.to_not raise_error ArgumentError
      end
    end

    context 'when value is 1.0' do
      it 'should not raise an error' do
        expect { subject.offset = 1.0 }.to_not raise_error ArgumentError
      end
    end
    
    context 'when value is lower than -1.0' do
      it 'should not raise an error' do
        expect { subject.offset = 0.9999 }.to_not raise_error ArgumentError
      end
    end

    context 'when value lower than -1.0' do
      it 'should raise an error' do
        expect { subject.offset = -1.0001 }.to raise_error ArgumentError
      end    
    end

    context 'when value greater than 1.0' do
      it 'should raise an error' do
        expect { subject.offset = 1.0001 }.to raise_error ArgumentError
      end    
    end
  end
end