class Controller
  def initialize request
    @request = request
  end

  def invoke
    raise InvalidParameters unless valid?
    execute
  end

  def valid?
    true
  end

  def execute
  end

  class InvalidParameters < StandardError
  end
end