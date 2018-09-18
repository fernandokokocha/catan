class Controller
  def initialize request
    @request = request
  end

  def invoke
    error = validate
    if error
      raise InvalidParameters.new(error)
    else
      execute
    end
  end

  def validate
    nil
  end

  def execute
  end

  class InvalidParameters < StandardError
  end
end
