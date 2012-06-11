class Blacksmith::Glyph
  include SmartProperties
  
  property :outline, :required => true,
                     :converts => :to_s,
                     :accepts => lambda { |filename| File.exist?(filename) }
  
  property :code, :required => true
  
  property :left_side_bearing, :required => true,
                               :converts => :to_i,
                               :default => 15

  property :right_side_bearing, :required => true,
                                :converts => :to_i,
                                :default => 15
  
  property :scale, :converts => :to_f,
                   :accepts => lambda { |scale| scale > 0.0 }
  
  property :offset, :converts => :to_f,
                    :accepts => lambda { |offset| offset <= 1.0 and offset >= -1.0 }
  
  def name
    File.basename(outline)
  end
  
end