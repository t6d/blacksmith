require 'smart_properties'
require 'erb'
require 'tempfile'
require 'singleton'

require 'blacksmith/font'
require 'blacksmith/font_builder'
require 'blacksmith/font_forge'
require 'blacksmith/glyph'
require 'blacksmith/version'

module Blacksmith
  
  Point = Struct.new(:x, :y)
  
  class << self
    
    def forge(filename = nil, &block)
      font         = create_font(&block)
      instructions = create_forging_instructions(font)
      
      FontForge.execute(instructions)
    end
    
    private
    
      def create_font(&block)
        FontBuilder.new(&block).build
      end
      
      def create_forging_instructions(font)
        font.instance_exec(forging_template) do |template|
          template.result(binding)
        end
      end
      
      def forging_template
        template = File.read(File.join(root_directory, 'support', 'build.py.erb'))
        ERB.new(template, nil, '<>')
      end
      
      def root_directory
        File.expand_path('../..', __FILE__)
      end
    
  end
end
