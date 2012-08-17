class Blacksmith::TTF::Table
  class << self
    
    protected :new
    
    def tag
      raise NotImplementError, "#{self}.tag not implemented"
    end

    def create_by_tag(tag, *args)
      if subclasses.include?(tag)
        subclasses[tag].new(*args)
      else
        ::Blacksmith::TTF::RawTable.new(*args)
      end
    end

    def inherited(subclass)
      subclass.instance_eval do
        public :new
      end
      
      subclasses[subclass.tag] = subclass unless subclass.tag.nil?
    end
    
    protected
    
      def subclasses
        @subclasses ||= {}
      end
    
  end
  
  attr_accessor :tag
  
end