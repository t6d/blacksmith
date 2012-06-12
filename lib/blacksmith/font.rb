class Blacksmith::Font
  include SmartProperties
  
  property :name, :converts => :to_s

  property :family, :required => true,
                    :converts => :to_s

  property :weight, :required => true,
                    :default => 'Regular'

  property :copyright, :converts => :to_s
  
  property :ascent, :required => true,
                    :converts => :to_i,
                    :accepts => lambda { |number| number > 0 },
                    :default => 800
                    
  property :descent, :required => true,
                     :converts => :to_i,
                     :accepts => lambda { |number| number > 0 },
                     :default => 200

  property :version, :required => true,
                     :converts => :to_s,
                     :accepts => lambda { |v| /\d+\.\d+(\.\d+)?/.match(v) },
                     :default => '1.0'

  property :baseline, :converts => :to_f,
                      :accepts => lambda { |baseline| baseline > 0.0 }

  property :scale, :converts => :to_f,
                   :accepts => lambda { |scale| scale > 0.0 }

  property :offset, :converts => :to_f,
                    :accepts => lambda { |offset| offset <= 1.0 and offset >= -1.0 }
  
  property :source, :required => true,
                    :converts => :to_s,
                    :accepts => lambda { |path| File.directory?(path) },
                    :default => 'glyphs'
  
  property :target, :required => true,
                    :converts => :to_s,
                    :accepts => lambda { |path| File.directory?(path) },
                    :default => '.'
  
  [:ttf, :eot, :woff, :svg, :css].each do |extension|
    name = "#{extension}_path"
    
    property name, :converts => :to_s,
                   :accepts => lambda { |filename| 
                     File.extname(filename) == ".#{extension}" and 
                     File.directory?(File.dirname(filename)) 
                   }
    
    define_method(name) do
      super() || File.join(target, "#{basename}.#{extension}")
    end
    
  end
  
  def name
    super || [family, weight].join(' ')
  end
  
  def identifier
    name.gsub(/\W+/, '_').downcase
  end
  
  def basename
    [family.gsub(/\W+/, ''), weight.gsub(/\W+/, '')].join('-')
  end
  
  def glyphs
    (@glyphs || []).dup
  end
  
  def <<(glyph)
    @glyphs ||= []
    @glyphs << glyph
  end
  
  def baseline
    super or (1.0 * descent) / (ascent + descent)
  end
  
  def origin
    Blacksmith::Point.new(0, (ascent + descent) * baseline - descent)
  end
  
  def to_fontforge_build_instructions
    fontforge_build_instructions_template.result(binding)
  end
  
  def to_fontforge_conversion_instructions
    fontforge_conversion_instructions_template.result(binding)
  end
  
  private
  
    def fontforge_build_instructions_template
      template = File.read(File.join(Blacksmith.support_directory, 'fontforge_build_instructions.py.erb'))
      ERB.new(template)
    end
    
    def fontforge_conversion_instructions_template
      template = File.read(File.join(Blacksmith.support_directory, 'fontforge_conversion_instructions.py.erb'))
      ERB.new(template)
    end
  
end