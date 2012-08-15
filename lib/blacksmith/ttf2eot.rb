module Blacksmith
  module TTF2EOT
  
    class TableDirectoryEntry < Struct.new(:tag, :check_sum, :offset, :length)
      class << self
        
        def from_data(data)
          if data
            raise ArgumentError, "Expected a #{size}-byte long String - got a #{data.bytesize}-byte long String instead" unless data.bytesize == size    
            new(*data.unpack("a4N3"))
          else
            nil
          end
        end
        
        def size
          16
        end
        
      end
      
    end
  
    class SFNTHeader < Struct.new(:major_version, :minor_version, :tables_count, :search_range, :entry_selector, :range_shift, :tables)    
      class << self
        
        def from_data(data)
          header = parse_header_without_table_directory(data)
          tables = parse_table_directory(data)
          
          header.push(tables)
          
          new(*header)
        end
        
        def size
          header_without_directory_entries_byte_size + tables.count * TableDirectoryEntry.size
        end
        
        private
        
          def header_without_table_directory_size
            12
          end
          
          def parse_header_without_table_directory(data)
            return *data.unpack("n6")
          end
          
          def parse_table_directory(data)
            number_of_tables = data.unpack("@4n")[0]
            
            0.upto(number_of_tables - 1).map do |index|
              lower_bound = header_without_table_directory_size + (index * TableDirectoryEntry.size)
              upper_bound = header_without_table_directory_size + ((index + 1) * TableDirectoryEntry.size) - 1
              
              TableDirectoryEntry.from_data(data.byteslice(lower_bound .. upper_bound))
            end
          end
        
      end
      
    end
  
    def self.get_eot_header(data)
      SFNTHeader.from_data(data)
    end
  
  end
end