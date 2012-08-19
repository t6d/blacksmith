class Blacksmith::Executable
  
  def self.execute!(*args)
    new(*args).execute!
  end
  
  def execute!(opts = {})
    raise Blacksmith::DependencyMissing, instructions unless installed?
    
    if opts[:verbose]
      system(executable, *arguments)
    else
      silence { system(executable, *arguments) }
    end
  end
  
  
protected

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
  
  def executable
    raise NotImplementedError, "#{self.class} must implement #executable"
  end
  
  def arguments
    []
  end
  
  def instructions
    "#{executable} is not installed"
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