require 'smart_properties'
require 'erb'
require 'tempfile'

require 'blacksmith/font'
require 'blacksmith/font_builder'
require 'blacksmith/glyph'
require 'blacksmith/version'

module Blacksmith
  
  class << self
    
    def forge(filename = nil, &block)
      font = prepare_font(&block)
      forge_font(font)
    end
    
    private
    
      def prepare_font(&block)
        FontBuilder.new(&block).build
      end
      
      def forge_font(font)
        path = create_forging_instructions(font)
        create_font_from_instructions(path)
        File.unlink(path)
      end
      
      def create_forging_instructions(font)
        script = Tempfile.new('fontforge-instructions')
        
        script << font.instance_exec(forging_template) do |template|
          template.result(binding)
        end
        
        script.close
        script.path
      end
      
      def forging_template
        template = File.read(File.join(root_directory, 'support', 'build.py.erb'))
        ERB.new(template, nil, '<>')
      end
      
      def root_directory
        File.expand_path('../..', __FILE__)
      end
      
      def create_font_from_instructions(path)
        `fontforge -lang=py -script #{path}`
      end
    
  end
  
  
end
