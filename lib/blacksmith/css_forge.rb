class Blacksmith::CSSForge
  class << self
    def execute(font)
      File.open(font.css_path, 'w+') do |file|
        file.write(stylesheet_template.result(binding))
      end
    end
  
    private
  
      def stylesheet_template
        template = File.read(File.join(Blacksmith.support_directory, 'font.css.erb'))
        ERB.new(template)
      end
  end
end
