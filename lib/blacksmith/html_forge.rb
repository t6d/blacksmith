class Blacksmith::HTMLForge
  class << self
    def execute(font)
      File.open(font.html_path, 'w+') do |file|
        file.write(html_template.result(binding))
      end
    end

    private

      def html_template
        template = File.read(File.join(Blacksmith.support_directory, 'font.html.erb'))
        ERB.new(template)
      end
  end
end
