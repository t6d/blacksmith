require 'tempfile'

class Blacksmith::FontForge

  def self.execute!(path)
    new(path).execute!
  end

  def initialize(path)
    @path = path
  end

  def execute!
    raise Blacksmith::DependencyMissing, instructions unless installed?

    silence do
      system(executable, '-lang=py', '-script', @path)
    end
  end

private

  def installed?
    @installed unless @installed.nil?

    paths      = ENV['PATH'].split(File::PATH_SEPARATOR)
    extensions = ENV['PATHEXT'] ? ENV['PATHEXT'].split(File::PATH_SEPARATOR) : ['']

    @installed = !!paths.find do |path|
      extensions.find do |ext|
        File.executable?(File.join(path, "#{executable}#{ext}"))
      end
    end
  end

  def instructions
    "FontForge is not installed!"
  end

  def executable
    'fontforge'
  end

  def silence
    err = $stderr.dup
    $stderr.reopen('/dev/null')
    yield
  ensure
    $stderr.close
    $stderr = err
  end

end
