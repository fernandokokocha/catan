require_relative 'controller'

class GainResourcesAroundCity < Controller
  def execute
    @map.get_fields_of_place(@place).each do |field|
      next if field.resource == :desert
      @current_player.resources[field.resource] += 1
    end
  end

  def valid?
    return false unless @request.is_a?(Hash)
    return false unless @request.has_key?(:map)
    return false unless @request.has_key?(:place)
    return false unless @request.has_key?(:current_player)

    @map = @request[:map]
    @place = @request[:place]
    @current_player = @request[:current_player]

    return false unless @map.is_a?(Map)
    return false unless @place.is_a?(Integer)
    return false unless @current_player.is_a?(Player)

    true
  end
end
