require 'smart_properties'
require 'erb'
require 'tempfile'
require 'singleton'

class Blacksmith
  Point = Struct.new(:x, :y)
  
  class Error < ::RuntimeError; end
  class DependencyMissing < Error; end

  class << self
    
    def run(args = [])
      if args.empty?
        new(File.join(Dir.pwd, 'Forgefile')).forge
      end
    end
    
    def forge(*args, &block)
      new(*args, &block).forge
    end
    
    def root_directory
      File.expand_path('../..', __FILE__)
    end
    
    def support_directory
      File.join(root_directory, 'support')
    end

  end
  
  def initialize(filename = nil, &block)
    @font = FontBuilder.execute(filename, &block)
  end
  
  def forge
    check_environment
    
    forge_font
    auto_hint_font
    convert_font
    forge_css
    forge_html
  end

  protected
    
    attr_reader :font
    
    def check_environment
      FontForge.check_dependency!
      TTFAutoHint.check_dependency!
    end
    
    def forge_font
      FontForge.execute(font.to_fontforge_build_instructions)
    end
    
    def auto_hint_font
      TTFAutoHint.execute(font.ttf_path)
    end
    
    def convert_font
      FontForge.execute(font.to_fontforge_conversion_instructions)
    end

    def forge_css
      CSSForge.execute(font)
    end

    def forge_html
      HTMLForge.execute(font)
    end
end

require 'blacksmith/executable'
require 'blacksmith/font_forge'
require 'blacksmith/ttf_auto_hint'
require 'blacksmith/css_forge'
require 'blacksmith/html_forge'

require 'blacksmith/font'
require 'blacksmith/font_builder'
require 'blacksmith/glyph'

require 'blacksmith/version'
