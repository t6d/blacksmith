module Blacksmith
  class FontBuilder
    
    def initialize(&block)
      @_instructions = block
      @_attributes = {}
      @_glyphs = {}
      @_source = '.'
    end
    
    def build
      instance_eval(&@_instructions)
      
      font = Font.new(@_attributes)
      
      @_glyphs.each do |name, attrs|
        attrs[:scale] ||= font.scale
        attrs[:outline] ||= File.join(@_source, "#{name}.svg")
        font << Glyph.new(attrs)
      end
      
      font
    end
    
    def source(path = nil)
      if path
        raise ArgumentError, "Directory does not exist: #{path}" unless File.directory?(path)
        @_source = path
      else
        @_source
      end
    end
    
    def target(path = nil)
      if path
        raise ArgumentError, "Directory does not exist: #{path}" unless File.directory?(File.dirname(path))
        @_attributes[:filename] = path
      else
        @_attributes[:filename]
      end
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
end