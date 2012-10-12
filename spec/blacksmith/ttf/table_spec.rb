require 'spec_helper'

describe Blacksmith::TTF::Table do
  
  table_class_builder = lambda do |&block|
    Class.new(described_class).tap do |c|
      c.instance_eval(&block)
    end
  end
  
  context "when building a new table type that has a property that only allows unsigned shorts" do
    
    subject do
      table_class_builder.call { unsigned_short :some_unsigned_short }
    end
    
    it "should be possible to create new instances of this class" do
      subject.new.should be_an_instance_of(subject)
    end
    
    context "instances of this class" do
      
      klass = subject.call
      subject { klass.new }
      
      it "should allow 0 as value for this property" do
        expect { subject.some_unsigned_short = stub(:to_i => 0) }.not_to raise_error
        subject.some_unsigned_short.should be == 0
      end
      
      it "should allow 65535 as value for this property" do
        expect { subject.some_unsigned_short = stub(:to_i => 65535) }.not_to raise_error
        subject.some_unsigned_short.should be == 65535
      end
      
      it "should not allow 65536 as value for this property" do
        expect { subject.some_unsigned_short = stub(:to_i => 65536) }.to raise_error(ArgumentError)
      end
      
      it "should not allow -1 as value for this property" do
        expect { subject.some_unsigned_short = stub(:to_i => -1) }.to raise_error(ArgumentError)
      end
      
    end
    
  end
  
  context "when building a new table type that has a property that only accepts a value in the range of an byte" do
    
    context "instances of this class" do
      
      subject { table_class_builder.call { byte :some_byte }.new }
      
      it "should allow 0 as value for this property" do
        expect { subject.some_byte = stub(:to_i => 0) }.not_to raise_error
        subject.some_byte.should be == 0
      end
      
      it "should allow 255 as value for this property" do
        expect { subject.some_byte = stub(:to_i => 255) }.not_to raise_error
        subject.some_byte.should be == 255
      end
      
      it "should not allow 256 as value for this property" do
        expect { subject.some_byte = stub(:to_i => 256) }.to raise_error(ArgumentError)
      end
      
      it "should not allow -1 as value for this property" do
        expect { subject.some_byte = stub(:to_i => -1) }.to raise_error(ArgumentError)
      end
      
    end
    
  end
  
  context "when building a new table type that has a property that only accepts a value in the range of an char" do
    
    context "instances of this class" do
      
      subject { table_class_builder.call { char :some_char }.new }
      
      it "should allow -128 as value for this property" do
        expect { subject.some_char = stub(:to_i => -128) }.not_to raise_error
        subject.some_char.should be == -128
      end
      
      it "should allow 127 as value for this property" do
        expect { subject.some_char = stub(:to_i => 127) }.not_to raise_error
        subject.some_char.should be == 127
      end
      
      it "should not allow 128 as value for this property" do
        expect { subject.some_char = stub(:to_i => 128) }.to raise_error(ArgumentError)
      end
      
      it "should not allow -129 as value for this property" do
        expect { subject.some_char = stub(:to_i => -129) }.to raise_error(ArgumentError)
      end
      
    end
    
  end
  
  context "when building a new table type that has a property that only accepts a value in the range of an unsigned long" do
    
    context "instances of this class" do
      
      subject { table_class_builder.call { unsigned_long :some_unsigned_long }.new }
      
      it "should allow 0 as value for this property" do
        expect { subject.some_unsigned_long = stub(:to_i => 0) }.not_to raise_error
        subject.some_unsigned_long.should be == 0
      end
      
      it "should allow 4294967295 as value for this property" do
        expect { subject.some_unsigned_long = stub(:to_i => 4294967295) }.not_to raise_error
        subject.some_unsigned_long.should be == 4294967295
      end
      
      it "should not allow 4294967296 as value for this property" do
        expect { subject.some_unsigned_long = stub(:to_i => 4294967296) }.to raise_error(ArgumentError)
      end
      
      it "should not allow -1 as value for this property" do
        expect { subject.some_unsigned_long = stub(:to_i => -1) }.to raise_error(ArgumentError)
      end
      
    end
    
  end
  
  context "when building a new table type that has a property that only accepts a value in the range of an long" do
    
    context "instances of this class" do
      
      subject { table_class_builder.call { long :some_long }.new }
      
      it "should allow -2147483648 as value for this property" do
        expect { subject.some_long = stub(:to_i => -2147483648) }.not_to raise_error
        subject.some_long.should be == -2147483648
      end
      
      it "should allow 2147483647 as value for this property" do
        expect { subject.some_long = stub(:to_i => 2147483647) }.not_to raise_error
        subject.some_long.should be == 2147483647
      end
      
      it "should not allow 2147483648 as value for this property" do
        expect { subject.some_long = stub(:to_i => 2147483648) }.to raise_error(ArgumentError)
      end
      
      it "should not allow -2147483649 as value for this property" do
        expect { subject.some_long = stub(:to_i => -2147483649) }.to raise_error(ArgumentError)
      end
      
    end
    
  end
  
  context "when building a new table type that has a property that only accepts a value in the range of a long long" do
    
    context "instances of this class" do
      
      subject { table_class_builder.call { long_long :some_long_long }.new }
      
      it "should allow -9223372036854775808  as value for this property" do
        expect { subject.some_long_long = stub(:to_i => -9223372036854775808) }.not_to raise_error
        subject.some_long_long.should be == -9223372036854775808
      end
      
      it "should allow 9223372036854775808 as value for this property" do
        expect { subject.some_long_long = stub(:to_i => 9223372036854775807) }.not_to raise_error
        subject.some_long_long.should be == 9223372036854775807
      end
      
      it "should not allow 9223372036854775808 as value for this property" do
        expect { subject.some_long_long = stub(:to_i => 9223372036854775808) }.to raise_error(ArgumentError)
      end
      
      it "should not allow -9223372036854775809 as value for this property" do
        expect { subject.some_long_long = stub(:to_i => -9223372036854775809) }.to raise_error(ArgumentError)
      end
      
    end
    
  end
  
end