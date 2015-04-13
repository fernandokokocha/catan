class SetupGame
  def initialize
  end

  def invoke request
    raise InvalidParameters if request.nil?
    raise InvalidParameters unless request.is_a?(Hash)
    raise InvalidParameters unless request.has_key?(:layers_count)
    raise InvalidParameters if request[:layers_count] <= 0
    [Map.new(request[:layers_count]), 0]
  end

  class InvalidParameters < StandardError
  end
end