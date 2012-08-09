require 'spec_helper'

describe Blacksmith::Font do

  subject { described_class.new(properties) }

  let(:properties) do
    {
      :family => 'Spec'
    }
  end

  before { File.stub(:directory? => true) }

  it { should have_property(:name) }
  it { should have_property(:family) }
  it { should have_property(:weight) }
  it { should have_property(:copyright) }
  it { should have_property(:ascent) }
  it { should have_property(:descent) }
  it { should have_property(:version) }
  it { should have_property(:baseline) }
  it { should have_property(:scale) }
  it { should have_property(:offset) }

  its(:weight) { should eq('Regular') }
  its(:ascent) { should eq(800) }
  its(:descent) { should eq(200) }
  its(:version) { should eq('1.0') }

  describe '#name' do
    context 'when no name is given' do
      before { properties.delete(:name) }

      it 'should combine family and weight' do
        subject.name.should eq('Spec Regular')
      end
    end
  end

  describe '#identifier' do
    context 'when no identifier is given' do
      before { properties.delete(:identifier) }

      it 'should derive the identifier from the name' do
        subject.identifier.should eq('spec_regular')
      end
    end
  end

  describe '#basename' do
    context 'when no identifier is given' do
      before { properties.delete(:basename) }
  
      it 'should derive the basename from the name' do
        subject.basename.should eq('Spec-Regular')
      end
    end
  end

  describe '#ascent=' do
    context 'when value is greater than zero' do
      it 'should not raise an error' do
        expect { subject.ascent = 1 }.to_not raise_error ArgumentError
      end    
    end

    context 'when value is zero' do
      it 'should raise an error' do
        expect { subject.ascent = 0 }.to raise_error ArgumentError
      end
    end

    context 'when value is lower than zero' do
      it 'should not raise an error' do
        expect { subject.ascent = -1 }.to raise_error ArgumentError
      end
    end
  end

  describe '#descent=' do
    context 'when value is greater than zero' do
      it 'should not raise an error' do
        expect { subject.descent = 1 }.to_not raise_error ArgumentError
      end    
    end
  
    context 'when value is zero' do
      it 'should raise an error' do
        expect { subject.descent = 0 }.to raise_error ArgumentError
      end
    end
  
    context 'when value is lower than zero' do
      it 'should not raise an error' do
        expect { subject.descent = -1 }.to raise_error ArgumentError
      end
    end
  end

  describe '#version=' do
    context 'when value is a valid version' do
      it 'should not raise an error' do
        expect { subject.version = '1.2.3' }.to_not raise_error ArgumentError
      end    
    end

    context 'when value is not a valid version' do
      it 'should raise an error' do
        expect { subject.version = 'a.b.c' }.to raise_error ArgumentError
      end
    end
  end

  describe '#baseline' do
    context 'when no baseline is given' do
      before { properties.delete(:baseline) }

      it 'should calculate the baseline from ascent and descent' do
        subject.ascent = 10; subject.descent = 6
        subject.baseline.should eq(0.375)
      end
    end
  end

  describe '#baseline=' do
    context 'when value is greater than zero' do
      it 'should not raise an error' do
        expect { subject.baseline = 0.0001 }.to_not raise_error ArgumentError
      end
    end
  
    context 'when value is zero' do
      it 'should raise an error' do
        expect { subject.baseline = 0.0 }.to raise_error ArgumentError
      end
    end
  
    context 'when value is lower than zero' do
      it 'should not raise an error' do
        expect { subject.baseline = -0.0001 }.to raise_error ArgumentError
      end
    end
  end

  describe '#scale=' do
    context 'when value is greater than zero' do
      it 'should not raise an error' do
        expect { subject.scale = 0.0001 }.to_not raise_error ArgumentError
      end
    end

    context 'when value is zero' do
      it 'should raise an error' do
        expect { subject.scale = 0.0 }.to raise_error ArgumentError
      end
    end

    context 'when value is lower than zero' do
      it 'should not raise an error' do
        expect { subject.scale = -0.0001 }.to raise_error ArgumentError
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

  describe '#origin' do
    it 'should be calculated from ascent, descent and baseline' do
      subject.ascent = 10; subject.descent = 6; subject.baseline = 0.5
      subject.origin.should eq(Blacksmith::Point.new(0, 2.0))
    end
  end
end