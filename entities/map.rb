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

  def get_neighbours index
    if index == 1
      [self.get_place(2), self.get_place(6), self.get_place(24)]
    elsif index == 2
      [self.get_place(1), self.get_place(3), self.get_place(9)]
    else
      [self.get_place(2), self.get_place(4), self.get_place(12)]
    end
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