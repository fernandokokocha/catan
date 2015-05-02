require_relative 'controller'

class RoadSettleForFree < Controller
  def invoke
    raise InvalidParameters unless valid?
  end
  
  private
  def valid?
    return false unless @request.is_a?(Hash)
    return false unless @request.has_key?(:map)
    return false unless @request.has_key?(:place)
    return false unless @request.has_key?(:neighbour)

    map = @request[:map]
    place = @request[:place]
    neighbour = @request[:neighbour]

    return false unless map.is_a?(Map)
    return false unless place.is_a?(Fixnum)
    map.get_place(place) rescue return false
    map.get_place(neighbour) rescue return false
    map.get_neighbours(place).include? map.get_place(neighbour) rescue return false
    
    true
  end
end