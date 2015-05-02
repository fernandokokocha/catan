class Controller
  def initialize request
    @request = request
  end

  class InvalidParameters < StandardError
  end
end