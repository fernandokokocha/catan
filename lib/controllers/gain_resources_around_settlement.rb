class GainResourcesAroundSettlement < Controller
  def expected_params
    {
      map: Map,
      place: Integer,
      current_player: Player
    }
  end

  def validate
    error = validate_params and return error

    nil
  end

  def execute
    @map = @request[:map]
    @place = @request[:place]
    @current_player = @request[:current_player]

    @map.get_fields_of_place(@place).each do |field|
      next if field.resource == :desert

      @current_player.resources[field.resource] += 1
    end
  end
end
