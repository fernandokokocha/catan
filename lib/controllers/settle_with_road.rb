class SettleWithRoad < Controller
  def expected_params
    {
      map: Map,
      place: :any,
      neighbour: :any,
      current_player: Player
    }
  end

  def validate
    error = validate_params and return error

    @map = @request[:map]
    @place = @request[:place]
    @neighbour = @request[:neighbour]
    @current_player = @request[:current_player]

    return 'Invalid :place value' if validate_place(@place)
    return 'Invalid :neighbour value' if validate_place(@neighbour)
    return "Place and neighbour don't border" unless @map.get_neighbours(@place).include? @map.place(@neighbour)
    return 'Cannot settle this place' unless @map.can_settle? @place

    nil
  end

  def execute
    @map.settle_place(@place, @current_player)
    @map.build_road(@place, @neighbour, @current_player)
  end

  def validate_place(place)
    @map.place(place)
    nil
  rescue Map::WrongIndexError
    'Place not present on the map'
  end
end
