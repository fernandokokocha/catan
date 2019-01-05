class Controller
  def initialize(request)
    @request = request
  end

  def invoke
    error = validate
    raise InvalidParameters, error if error

    execute
  end

  def validate
    nil
  end

  def execute; end

  class InvalidParameters < StandardError
  end
end
