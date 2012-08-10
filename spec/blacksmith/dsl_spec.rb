require 'spec_helper'

describe Blacksmith::DSL do

  subject { described_class.new(font) }
  let(:font) { mock(:font, :glyphs => []) }

  describe '.evaluate' do
    it 'should return an instace of Blacksmith::Font' do
      described_class.evaluate { }.should be_kind_of(Blacksmith::Font)
    end

    context 'when used with a string' do
      it 'should read the given file' do
        source = "family 'MyFont'\n"
        File.open('example', 'w') { |f| f.write source }
        described_class.any_instance.should_receive(:evaluate).with(source)
        described_class.evaluate('example')
      end
    end

    context 'when used with a block' do
      it 'should pass the given block' do
        block = Proc.new { family 'MyFont' }
        described_class.any_instance.should_receive(:evaluate).with(block)
        described_class.evaluate(&block)
      end
    end
  end

  describe '#evaluate' do
    context 'when used with a string' do
      it 'should evaluate the given string' do
        font.should_receive(:family=).with('MyFont')
        subject.evaluate "family 'MyFont'"
      end
    end

    context 'when used with a block' do
      it 'should evaluate the given string' do
        font.should_receive(:family=).with('MyFont')
        subject.evaluate(Proc.new { family 'MyFont' })
      end
    end
  end

  [:name, :family, :weight, :copyright, :ascent, :descent, :version, :baseline, :scale, :offset].each do |property|
    describe "##{property}" do
      it 'should set the font family' do
        font.should_receive("#{property}=").with(:value)
        subject.public_send(property, :value)
      end
    end
  end

  describe '#glyph' do
    let(:options) { Hash.new }
    let(:expanded_options) { options.merge(:source => 'source/glyph.svg') }
    let(:glyph) { mock(:glyph) }

    before { Blacksmith::Glyph.stub(:new).and_return(glyph) }

    it 'should add the glyph to the font' do
      expect do
        subject.glyph 'glyph.svg'
      end.to change { font.glyphs.count }.from(0).to(1)
    end

    it 'should pass any additional options to the Blacksmith::Glyph initializer' do
      options.merge!(:scale => 2.0)
      Blacksmith::Glyph.should_receive(:new).with(expanded_options).and_return(glyph)
      subject.glyph 'glyph.svg', options
    end

  end

end
