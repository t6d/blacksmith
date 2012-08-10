require 'thor'

class Blacksmith::Runner < Thor
  include Thor::Actions

  default_task :generate

  source_root File.expand_path('../../../support', __FILE__)

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
    self.font = Blacksmith::DSL.evaluate(forgefile_path)

    tempfile('fontforge_build_instructions.py') do |path|
      template('fontforge_build_instructions.py.tt', path, :verbose => false)
      Blacksmith::FontForge.execute!(path)
      say_status :create, "build/#{font.basename}.ttf"
      say_status :create, "build/#{font.basename}.eot"
      say_status :create, "build/#{font.basename}.svg"
      say_status :create, "build/#{font.basename}.woff"
    end

    template('font.css.tt', "build/#{font.basename}.css")
    template('font.html.tt', "build/#{font.basename}.html")
  end

  desc "version", "Displays the version"
  def version
    say "Blacksmith v#{Blacksmith::VERSION}"
  end

private

  attr_accessor :font

  def forgefile_path
    File.join(Dir.pwd, 'Forgefile')
  end

  def tempfile(name)
    path = File.join(Dir::tmpdir, name)
    yield path
  ensure
    FileUtils.remove_entry_secure path
  end

  def source_paths
    [File.join(Dir.pwd, 'support')] + super
  end
end
