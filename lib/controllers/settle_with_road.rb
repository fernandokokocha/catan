class SettleWithRoad < Controller
  def execute
    @map.settle_place(@place, @current_player)
    @map.build_road(@place, @neighbour, @current_player)
  end

  def validate
    return 'Params is not a hash' unless @request.is_a?(Hash)
    return 'Missing :map key in params' unless @request.key?(:map)
    return 'Missing :place key in params' unless @request.key?(:place)
    return 'Missing :neighbour key in params' unless @request.key?(:neighbour)
    return 'Missing :current_player key in params' unless @request.key?(:current_player)

    @map = @request[:map]
    @place = @request[:place]
    @neighbour = @request[:neighbour]
    @current_player = @request[:current_player]

    return ':map value is not a Map' unless @map.is_a?(Map)
    return ':current_player value is not a Player' unless @current_player.is_a?(Player)
    return 'Invalid :place value' if validate_place(@place)
    return 'Invalid :neighbour value' if validate_place(@neighbour)
    return "Place and neighbour don't border" unless @map.get_neighbours(@place).include? @map.place(@neighbour)
    return 'Cannot settle this place' unless @map.can_settle? @place

    nil
  end

  def validate_place(place)
    @map.place(place)
    nil
  rescue Map::WrongIndexError
    'Place not present on the map'
  end
end
