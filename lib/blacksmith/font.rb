require 'smart_properties'

class Blacksmith::Font
  include SmartProperties

  property :name, :converts => :to_s

  property :family, :required => true,
                    :default => 'Blacksmith Font',
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

  def name
    super || [family, weight].join(' ')
  end

  def identifier
    name.gsub(/\W+/, '_').downcase
  end

  def basename
    name.gsub(/\W+/, '-')
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

end
