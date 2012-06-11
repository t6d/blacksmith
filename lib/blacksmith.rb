require 'smart_properties'
require 'erb'
require 'tempfile'
require 'singleton'

class Blacksmith
  Point = Struct.new(:x, :y)
  
  class Error < ::RuntimeError; end
  class DependencyMissing < Error; end

  class << self

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
    @font = build_font(&block)
  end
  
  def forge
    check_environment
    
    forge_font
    auto_hint_font
    convert_font
  end

  protected
    
    attr_reader :font
    
    def build_font(&block)
      FontBuilder.execute(&block)
    end
    
    def check_environment
      FontForge.check_dependency!
      TTFAutoHint.check_dependency!
    end
    
    def forge_font
      FontForge.execute(font.to_fontforge_build_instructions)
    end
    
    def auto_hint_font
      TTFAutoHint.execute(font)
    end
    
    def convert_font
    end

end

require 'blacksmith/executable'
require 'blacksmith/font_forge'
require 'blacksmith/ttf_auto_hint'

require 'blacksmith/font'
require 'blacksmith/font_builder'
require 'blacksmith/glyph'

require 'blacksmith/version'
