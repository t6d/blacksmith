module Blacksmith
  class FontForge
    include Singleton
    
    def self.method_missing(method, *args, &block)
      instance.send(method, *args, &block)
    end
    
    attr_reader :executable
    
    def initialize
      @executable = 'fontforge'
    end
    
    def execute(file_or_instructions)
      case file_or_instructions
      when String
        with_temporary_instuctions_file(file_or_instructions) do |path|
          execute!(path)
        end
      when File
        path = file_or_instructions.path
        execute!(path)
      else
        raise ArgumentError, "FontForge#execute expects a File or String"
      end
    end
    
    private
    
      def execute!(path)
        if executable_available?
          system(executable, '-lang=py', '-script', path)
        else
          raise "fontforge is not installed"
        end
      end
      
      def executable_available?
        @executable_available unless @executable_available.nil?
        
        @executable_available = !!executable_paths.find do |path|
          executable_extensions.find do |ext|
            File.executable?(File.join(path, "#{executable}#{ext}"))
          end
        end
      end
      
      def executable_paths
        ENV['PATH'].split(File::PATH_SEPARATOR)
      end
      
      def executable_extensions
        ENV['PATHEXT'] ? ENV['PATHEXT'].split(File::PATH_SEPARATOR) : ['']
      end
    
      def with_temporary_instuctions_file(instructions)
        script = Tempfile.new('fontforge-instructions')
        script.puts(instructions)
        script.close
        
        yield script.path
      ensure
        script.close unless script.closed?
        script.unlink
      end
    
  end
end