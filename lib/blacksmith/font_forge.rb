require 'tempfile'

class Blacksmith::FontForge < Blacksmith::Executable

  def executable
    'fontforge'
  end

  def execute(file_or_instructions)
    check_dependency!

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
      system(executable, '-lang=py', '-script', path)
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
