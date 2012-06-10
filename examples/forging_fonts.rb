require 'bundler/setup'
require 'blacksmith'

Blacksmith.forge do
  
  name "Blacksmith Medium"
  family "Blacksmith"
  
  source File.expand_path('../src', __FILE__)
  target File.expand_path('../blacksmith-medium.ttf', __FILE__)
  
  glyph 'star', code: 0x0061
  
end
