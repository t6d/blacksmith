require 'tmpdir'

module FileHelper

  def file(name, content = name, &block)
    block ||= lambda { |f| f.write(content) }
    FileUtils.mkdir_p(File.dirname(name))
    File.open(name, 'w', &block)
  end

  RSpec.configure do |config|
    config.include self

    config.around do |example|
      begin
        tempdir = Dir.mktmpdir
        Dir.chdir(tempdir) { example.run }
      ensure
        FileUtils.remove_entry_secure tempdir
      end
    end
  
  end

end