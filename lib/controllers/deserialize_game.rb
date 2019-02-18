class DeserializeGame < Controller
  def expected_params
    {
      dump: String
    }
  end

  def validate
    error = validate_params and return error

    nil
  end

  def execute
    # eventually:
    # Marshal.load(@request[:dump])
    nil
  end
end
