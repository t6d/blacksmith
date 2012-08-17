require 'spec_helper'

describe Blacksmith::Runner do

  describe '#generate' do
    before do
      Blacksmith::FontForge.any_instance.stub(:execute!)
      file 'source/glyph.svg'
      file 'Forgefile', <<-EOF
        name 'My Font'

        glyph 'glyph.svg', :code => 0x100
      EOF
    end

    context 'with default support files' do
      before { capture(:stdout) { subject.generate } }

      it 'should generate a css file' do
        File.file?('build/My-Font.css').should be_true
      end

      it 'should generate a html file' do
        File.file?('build/My-Font.html').should be_true
      end
    end

    context 'with overloaded support files' do
      before do
        file 'support/font.css.tt', 'Custom Content'
        capture(:stdout) { subject.generate }
      end

      it 'should use the overloaded file' do
        File.read('build/My-Font.css').should eq("Custom Content")
      end
    end

    context 'with additional support files' do
      before do
        file 'support/font.scss.tt', 'Custom Content'
        capture(:stdout) { subject.generate }
      end
    
      it 'should generate the additional file' do
        File.read('build/My-Font.scss').should eq("Custom Content")
      end
    end
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
