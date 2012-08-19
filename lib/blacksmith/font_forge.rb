require 'tempfile'

class Blacksmith::FontForge < Blacksmith::Executable

  def initialize(path)
    @path = path
  end

protected

  def executable
    'fontforge'
  end

  def arguments
    ['-lang=py', '-script', @path]
  end

end
