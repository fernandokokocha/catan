require_relative 'controller'

class GainResourcesAroundSettlement < Controller
  def execute
    @map.get_fields_of_place(@place).each do |field|
      next if field.resource == :desert
      @current_player.resources[field.resource] += 1
    end
  end

  def validate
    return 'Params is not a hash' unless @request.is_a?(Hash)
    return 'Missing :map value key in params' unless @request.has_key?(:map)
    return 'Missing :place key in params' unless @request.has_key?(:place)
    return 'Missing :current_player key in params' unless @request.has_key?(:current_player)

    @map = @request[:map]
    @place = @request[:place]
    @current_player = @request[:current_player]

    return ':map key is not a Map' unless @map.is_a?(Map)
    return ':place key is not an Integer' unless @place.is_a?(Integer)
    return ':current_player key is not a Player' unless @current_player.is_a?(Player)

    nil
  end
end
