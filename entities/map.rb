require_relative 'place'

class Map
  attr_accessor :layers, :places

  def initialize layers
    raise Error if layers <= 0
    self.layers = layers
    self.places = prepare_places
  end

  def get_place index
    if index == :first
      return self.places.first
    elsif index == :last
      return self.places.last
    end
    raise BeyondRangeError if index < 1
    raise BeyondRangeError if index > 54
    self.places[index-1]
  end

  private
  def prepare_places
    result = []
    places = (@layers * @layers * 6)
    for index in (1..places) do
      result << Place.new(index)
    end
    result
  end

  class BeyondRangeError < StandardError
  end

end