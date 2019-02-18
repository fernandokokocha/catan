class SerializeGame < Controller
  def expected_params
    {
      game: Catan
    }
  end

  def validate
    error = validate_params and return error

    nil
  end

  def execute
    Marshal.dump(@request[:game])
  end
end
