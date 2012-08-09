require 'thor'

class Blacksmith::Runner < Thor

  default_task :generate

  desc "generate", "Generates the font"
  def generate
    say Time.now
  end
  
  desc "version", "Displays the version"
  def version
    say "Blacksmith v#{Blacksmith::VERSION}"
  end
  
  
end
