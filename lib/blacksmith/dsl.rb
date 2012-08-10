class Blacksmith::DSL

  def self.evaluate(forgefile = nil, &block)
    raise Blacksmith::Error, "Expects filename or block" unless forgefile || block
    raise Blacksmith::Error, "Expects either a block or a filename - not both" if forgefile and block
    raise Blacksmith::Error, "File not found: #{forgefile}" if forgefile && !File.exist?(forgefile)

    source = if forgefile
      File.read(forgefile)
    else
      block
    end

    new.evaluate(source)
  end

  def initialize(font = Blacksmith::Font.new)
    @_font = font
  end

  def evaluate(source)
    case source
    when Proc
      instance_eval(&source)
    when String
      instance_eval(source)
    end

    @_font
  end

  Blacksmith::Font.properties.each do |name, property|
    define_method(name) do |value|
      @_font.public_send("#{name}=", value)
    end
  end

  def glyph(filename, options = {})
    options[:source] = File.join('source', filename)
    glyph = Blacksmith::Glyph.new(options)
    @_font.glyphs << glyph
  end

end
