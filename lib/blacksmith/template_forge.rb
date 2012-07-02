class Blacksmith::TemplateForge
  class << self
    def execute(font, type)
      File.open(font.send("#{type}_path"), 'w+') do |file|
        file.write(template("font.#{type}.erb").result(binding))
      end
    end

    private

      def template(filename)
        template = File.read(File.join(Blacksmith.support_directory, filename))
        ERB.new(template)
      end
  end
end
