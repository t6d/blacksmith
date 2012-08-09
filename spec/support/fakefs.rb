require 'fakefs/safe'

RSpec.configure do |config|

  config.around do |example|
    FakeFS.activate!
    example.run
    FakeFS.deactivate!
    FakeFS::FileSystem.clear
  end

end