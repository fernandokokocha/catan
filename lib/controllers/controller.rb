class Controller
  def initialize request
    @request = request
  end

  def invoke
    raise InvalidParameters unless valid?
    execute
  end

  def vaild?
  end

  def execute
  end

  class InvalidParameters < StandardError
  end
end