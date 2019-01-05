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

  def validate_params
    return 'Params is not a hash' unless @request.is_a?(Hash)
    expected_params.entries.each do |param, type|
      return "Missing :#{param} key in params" unless @request.key?(param)
      next if type == :any
      return ":#{param} value is not of type #{type}" unless @request[param].is_a?(type)
    end

    nil
  end

  def execute; end

  class InvalidParameters < StandardError
  end
end
