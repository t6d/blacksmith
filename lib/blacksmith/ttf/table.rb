class Blacksmith::TTF::Table
  include SmartProperties
  
  class << self
    
    protected :new
    
    def tag
      nil
    end

    def create_by_tag(tag, *args)
      if subclasses.include?(tag)
        subclasses[tag].new(*args)
      else
        ::Blacksmith::TTF::RawTable.new(*args)
      end
    end

    def inherited(subclass)
      def subclass.new(*args, &block)
        super
      end
      
      subclasses[subclass.tag] = subclass unless subclass.tag.nil?
    end
    
    protected
    
      def subclasses
        @subclasses ||= {}
      end
      
      def unsigned_short(name)
        property(name, :converts => :to_i, :accepts => 0 .. 65535)
      end
      alias ufword unsigned_short
      
      def byte(name)
        property(name, :converts => :to_i, :accepts => 0 .. 255)
      end
      alias fword byte
      
      def char(name)
        property(name, :converts => :to_i, :accepts => -128 .. 127)
      end
      
      def long(name)
        property(name, :converts => :to_i, :accepts => -2147483648 .. 2147483647)
      end
      
      def unsigned_long(name)
        property(name, :converts => :to_i, :accepts => 0 .. 4294967295)
      end
    
  end
  
  attr_accessor :tag
  
end