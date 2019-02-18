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
    Marshal.load(@request[:dump])
  end
end
