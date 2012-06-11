class Blacksmith::FontBuilder
  class << self
    
    def execute(&block)
      new(&block).execute
    end
    
  end
  
  def initialize(&block)
    @_instructions = block
    @_attributes = {}
    @_glyphs = {}
    @_source = '.'
  end
  
  def execute
    instance_eval(&@_instructions)
    
    font = Blacksmith::Font.new(@_attributes)
    
    @_glyphs.each do |name, attrs|
      attrs[:scale]   ||= font.scale
      attrs[:offset]  ||= font.offset
      attrs[:outline] ||= File.join(font.source, "#{name}.svg")
      
      font << Blacksmith::Glyph.new(attrs)
    end
    
    font
  end

  def glyph(name, attrs)
    @_glyphs[name] = attrs
  end
  
  def method_missing(name, *args)
    if args.length == 1
      @_attributes[name] = args[0]
    else
      super
    end
  end
  
end