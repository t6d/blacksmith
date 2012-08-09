module Blacksmith
  Point = Struct.new(:x, :y)

  class Error < ::RuntimeError; end
  class DependencyMissing < Error; end

end

require 'blacksmith/executable'
require 'blacksmith/font_forge'
require 'blacksmith/ttf_auto_hint'
require 'blacksmith/template_forge'

require 'blacksmith/font'
require 'blacksmith/font_builder'
require 'blacksmith/glyph'

require 'blacksmith/version'
