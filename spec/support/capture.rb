RSpec.configure do |config|

  def capture(stream)
    eval "$#{stream} = StringIO.new"
    yield
    result = eval("$#{stream}").string
  ensure
    eval("$#{stream} = #{stream.to_s.upcase}")
  end

end
