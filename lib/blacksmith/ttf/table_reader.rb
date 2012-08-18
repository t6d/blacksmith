class Blacksmith::TTF::TableReader
  
  def initialize(table = nil, &block)
    @table_builder = if table
      table.kind_of?(Class) ? lambda { table.new } : lambda { table }
    elsif block
      block
    else
      proc(&::Blacksmith::TTF::Table.method(:create_by_tag))
    end
  end
  
  def read(tag, data)
    @data = data
    @tag = tag
    
    case tag
    when 'OS/2' then read_os2_table
    when 'head' then read_head_table
    when 'name' then read_name_table
    else
      read_raw_table
    end
  end
  
  protected
  
    attr_reader :table_builder
    attr_reader :data
    attr_reader :tag
  
  private
  
    def read_os2_table
      table = create_table
      
      table
    end
    
    def read_head_table
      create_table do |t|
        attrs = data.unpack("n4N2n2N4")
        
        t.major_version       = attrs.shift
        t.minor_version       = attrs.shift
        t.major_font_revision = attrs.shift
        t.minor_font_revision = attrs.shift
        t.check_sum           = attrs.shift
        t.magic_number        = attrs.shift
        t.flags               = attrs.shift
        t.units_per_em        = attrs.shift        
        t.created             = parse_date(*attrs.shift(2))
        t.modified            = parse_date(*attrs.shift(2))
      end
    end
    
    def read_name_table
      table = create_table
      
      table
    end
    
    def read_raw_table
      create_table do |t|
        t.data = data
      end
    end
    
    def create_table(&block)
      table = table_builder.call(tag).tap { |t| t.tag = tag }
      table.tap(&block) if block
      table
    end
    
    def parse_date(msb, lsb)
      (msb << 32) | lsb
    end
    
end