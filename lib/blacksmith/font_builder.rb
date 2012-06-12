class Blacksmith::FontBuilder
  class << self
    
    def execute(*args, &block)
      new(*args, &block).execute
    end
    
  end
  
  def initialize(filename = nil, &block)
    raise "Expects filename or block" unless filename || block
    raise "Expects either a block or a filename - not both" if filename and block
    raise "File not found: #{filename}" unless filename && File.exist?(filename)
    
    @_instructions = block || File.read(filename)
    @_attributes = {}
    @_glyphs = {}
  end
  
  def execute
    case @_instructions
    when String
      instance_eval(@_instructions)
    when Proc
      instance_eval(&@_instructions)
    end
    
    font = Blacksmith::Font.new(@_attributes)
    
    @_glyphs.each do |filename, attrs|
      attrs[:scale]  ||= font.scale
      attrs[:offset] ||= font.offset
      attrs[:source] ||= File.join(font.source, filename)
      
      font << Blacksmith::Glyph.new(attrs)
    end
    
    font
  end

  def glyph(filename, attrs)
    @_glyphs[filename] = attrs
  end
  
  def method_missing(name, *args)
    if args.length == 1
      @_attributes[name] = args[0]
    else
      super
    end
  end
  
end