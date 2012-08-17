module Blacksmith; end unless Kernel.const_defined?(:Blacksmith)

module Blacksmith::TTF
  
end

require 'blacksmith/ttf/font'
require 'blacksmith/ttf/table'

require 'blacksmith/ttf/table_reader'
require 'blacksmith/ttf/font_reader'