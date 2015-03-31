require_relative 'place'

class Map
  attr_accessor :layers, :places

  def initialize layers
    raise Error if layers <= 0
    @layers = layers
    @places = prepare_places
  end

  def get_place index
    if index.nil?
      return nil
    elsif index == :first
      return @places.first
    elsif index == :last
      return @places.last
    end
    raise BeyondRangeError if index < 1
    raise BeyondRangeError if index > 54
    @places[index-1]
  end

  def get_neighbours index
    place = get_place(index)
    circuit = 6*(2*place.layer - 1)
    circuit_sum = 6*(place.layer * place.layer)

    index1 = index + circuit - 1
    index1 -= circuit if index1 > circuit_sum
    index2 = index + 1
    index2 -= circuit if index2 > circuit_sum
    case place.layer
      when 1
        index3 = (index + 1) * 3
        index3 = 24 if index == 1
      when 2
        if [1,2].include? place.spot
          index3 = 19 + (place.side)*5 + (index-(4 + place.side*3))*3
          index3 += 30 if index3 < 25
        else
          index3 = (index - 3) / 3
          index3 -= 6 if index3 > 6
        end
      else
        if [1,2,4].include? place.spot
          index3 = nil
        else
          index3 = 2 + place.spot + place.side*3
          index3 -= 18 if index3 > 24
        end
    end

    [get_place(index1), get_place(index2), get_place(index3)].compact
  end

  class BeyondRangeError < StandardError
  end

  private
  def prepare_places
    max = (@layers * @layers * 6)
    (1..max).map { |index| Place.new(index) }
  end
end