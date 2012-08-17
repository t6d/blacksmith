module Blacksmith
  Point = Struct.new(:x, :y)

  class Error < ::RuntimeError; end
  class DependencyMissing < Error; end

end

require 'blacksmith/executable'
require 'blacksmith/font_forge'

require 'blacksmith/font'
require 'blacksmith/glyph'

require 'blacksmith/version'

require 'blacksmith/runner'
require 'blacksmith/dsl'

require 'blacksmith/ttf'