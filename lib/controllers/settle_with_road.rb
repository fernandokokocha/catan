require_relative 'controller'

class SettleWithRoad < Controller
  def execute
    @map.settle(@place, @current_player)
    @map.build_road(@place, @neighbour, @current_player)
  end

  def valid?
    return false unless @request.is_a?(Hash)
    return false unless @request.has_key?(:map)
    return false unless @request.has_key?(:place)
    return false unless @request.has_key?(:neighbour)
    return false unless @request.has_key?(:current_player)

    @map = @request[:map]
    @place = @request[:place]
    @neighbour = @request[:neighbour]
    @current_player = @request[:current_player]

    return false unless @map.is_a?(Map)
    return false unless @current_player.is_a?(Player)
    @map.get_place(@place) rescue return false
    @map.get_place(@neighbour) rescue return false
    return false unless @map.get_neighbours(@place).include? @map.get_place(@neighbour)
    return false unless @map.can_settle? @place
    
    true
  end
end