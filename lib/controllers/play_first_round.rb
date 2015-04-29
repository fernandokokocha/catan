class PlayFirstRound
  def initialize request
    @request = request
  end

  def invoke
    raise InvalidParameters unless @request.is_a?(Hash)
  end

  class InvalidParameters < StandardError
  end
end