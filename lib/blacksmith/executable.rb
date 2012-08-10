require 'singleton'

class Blacksmith::Executable
  include Singleton

  class << self

    def method_missing(name, *args, &block)
      instance.send(name, *args, &block)
    end

  end

  def executable
    raise NotImplementedError, "#{self.class} is expected to implement #executable"
  end

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

  def check_dependency!
    raise Blacksmith::DependencyMissing, "#{executable} not installed" unless installed?
  end

end
