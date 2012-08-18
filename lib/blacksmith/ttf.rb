module Blacksmith; end unless Kernel.const_defined?(:Blacksmith)

module Blacksmith::TTF
  
  Panose = Struct.new :family_type,
                      :serif_style,
                      :weight,
                      :propertion,
                      :contrast,
                      :stroke,
                      :arm_style,
                      :letterform,
                      :midline,
                      :x_height
  
end

require 'blacksmith/ttf/font'
require 'blacksmith/ttf/table'

require 'blacksmith/ttf/table_reader'
require 'blacksmith/ttf/font_reader'