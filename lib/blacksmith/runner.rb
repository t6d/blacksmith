require 'thor'

class Blacksmith::Runner < Thor
  include Thor::Actions

  default_task :generate

  desc "init", "Creates a new Blacksmith workspace"
  def init(name)
    path = name.downcase

    empty_directory(path)
    empty_directory(path + '/build')
    empty_directory(path + '/source')

    create_file(path + '/Forgefile') do
      "family '#{name}'\n"
    end
  end

  desc "generate", "Generates the font"
  def generate
    say Time.now
  end
  
  desc "version", "Displays the version"
  def version
    say "Blacksmith v#{Blacksmith::VERSION}"
  end


end
