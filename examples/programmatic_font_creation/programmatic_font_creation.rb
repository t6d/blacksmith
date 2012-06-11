require 'bundler/setup'
require 'blacksmith'

Blacksmith.forge do
  
  family "Blacksmith"
  source File.expand_path('../../glyphs', __FILE__)
  
  glyph 'star', code: 0x0061
  
end
