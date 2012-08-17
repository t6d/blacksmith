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
      table = create_table
      
      table
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
    
end