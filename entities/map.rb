require_relative 'place'
require_relative 'field'

class Map
  attr_accessor :layers, :places, :fields

  def initialize layers
    raise Error if layers <= 0
    @layers = layers
    @places = prepare_places
    @fields = prepare_fields
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

  def get_field index
    if index.nil?
      return nil
    elsif index == :first
      return @fields.first
    elsif index == :last
      return @fields.last
    end
    raise BeyondRangeError if index < 1
    raise BeyondRangeError if index > 19
    @fields[index-1]
  end

  def get_neighbours index
    get_neighbours_indexes(index).map { |i| get_place(i) }.compact
  end

  def get_fields_of_place index
    get_fields_indexes_of_place(index).map { |i| get_field(i) }
  end

  class BeyondRangeError < StandardError
  end

  private
  def prepare_places
    max = (@layers * @layers * 6)
    (1..max).map { |index| Place.new(index) }
  end

  def prepare_fields
    max = (1+6+12)
    (1..max).map { |index| Field.new(index) }
  end
  
  def get_neighbours_indexes index
    place = get_place(index)
    circuit = 6*(2*place.layer - 1)
    circuit_sum = 6*(place.layer * place.layer)

    result = Array.new(3)
    result[0] = index + circuit - 1
    result[0] -= circuit if result[0] > circuit_sum
    result[1] = index + 1
    result[1] -= circuit if result[1] > circuit_sum
    case place.layer
      when 1
        result[2] = (index + 1) * 3
        result[2] = 24 if index == 1
      when 2
        if [1,2].include? place.spot
          result[2] = 19 + (place.side)*5 + (index-(4 + place.side*3))*3
          result[2] += 30 if result[2] < 25
        else
          result[2] = (index - 3) / 3
          result[2] -= 6 if result[2] > 6
        end
      else
        if [1,2,4].include? place.spot
          result[2] = nil
        else
          result[2] = 2 + place.spot + place.side*3
          result[2] -= 18 if result[2] > 24
        end
    end
    result
  end

  def get_fields_indexes_of_place(index)
    place = get_place(index)

    result = Array.new(3)
    if index <=6
      result[0] = 1
      result[1] = index
      result[1] += 6 if result[1] < 2
      result[2] = index + 1
    else
      if index < 10
        result[0] = 2
      else
        result[0] = 3
      end

      result[1] = index - place.side + 1
      result[1] += 12 if result[1] <= 7

      if [1,2].include? place.spot
        result[2] = index - place.side + 2
      else
        result[2] = 3
      end
    end
    result
  end
end