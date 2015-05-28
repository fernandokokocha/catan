require_relative 'place'
require_relative 'field'

class Map
  attr_accessor :layers_count, :places, :fields

  def initialize
    @layers_count = 3
    @places = prepare_places
    @fields = prepare_fields
  end

  def get_place index
    return nil if index.nil?
    return @places.first if index == :first
    return @places.last if index == :last
    raise BeyondRangeError unless index.between?(1,54)
    @places[index-1]
  end

  def get_field index
    return nil if index.nil?
    return @fields.first if index == :first
    return @fields.last if index == :last
    raise BeyondRangeError unless index.between?(1,19)
    @fields[index-1]
  end

  def get_neighbours index
    return nil if index.nil?
    get_neighbours_indexes(index).map { |i| get_place(i) }
  end

  def get_fields_of_place index
    return nil if index.nil?
    get_fields_indexes_of_place(index).map { |i| get_field(i) }
  end

  def get_places_of_field index
    return nil if index.nil?
    get_places_indexes_of_field(index).map { |i| get_place(i) }
  end

  def layers_count
    @layers_count
  end

  def places_count
    @places.count
  end

  def fields_count
    @fields.count
  end

  def settle index, player
    get_place(index).settle player
  end

  def can_settle? index
    return false if get_place(index).settled_by
    return false if get_neighbours(index).select { |place| place.settled_by }.any?

    true
  end

  def build_road place, neighbour, player
    get_place(place).add_road(neighbour, player)
    get_place(neighbour).add_road(place, player)
  end

  class BeyondRangeError < StandardError
  end

  private
  def prepare_places
    max = (@layers_count * @layers_count * 6)
    (1..max).map { |index| Place.new(index) }
  end

  def prepare_fields
    max = (1+6+12)
    resources = resources_base
    numbers = numbers_base
    fields = []
    fields << Field.new(1, :desert, 7)
    (2..max).each do |index|
      r = resources.shuffle!.pop
      n = numbers.shuffle!.pop
      fields << Field.new(index, r, n)
    end
    fields
  end

  def numbers_base
    Array.new(1, 2) +
        Array.new(2, 3) +
        Array.new(2, 4) +
        Array.new(2, 5) +
        Array.new(2, 6) +
        Array.new(2, 8) +
        Array.new(2, 9) +
        Array.new(2, 10) +
        Array.new(2, 11) +
        Array.new(1, 12)
  end

  def resources_base
    Array.new(3, :ore) +
        Array.new(3, :brick) +
        Array.new(4, :wool) +
        Array.new(4, :grain) +
        Array.new(4, :lumber)
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
        if [3,5].include? place.spot
          result[2] = 2 + place.spot + place.side*3
          result[2] -= 18 if result[2] > 24
        end
    end
    result.compact
  end

  def get_fields_indexes_of_place(index)
    place = get_place(index)

    result = Array.new(3)
    base = place.layer < 3 ? 1 : 6
    result[0] = base + place.side*(place.layer - 1)
    result[0] += 1 if place.spot > 3
    case place.layer
      when 1
        result[1] = index
        result[1] += 6 if result[1] < 2
        result[2] = index + 1
      when 2
        result[1] = index - place.side + 1
        result[1] += 12 if result[1] <= 7

        if [1,2].include? place.spot
          result[2] = index - place.side + 2
        else
          result[2] = 2 + place.side
          result[2] -= 6 if result[2] > 7
        end
      else
        if place.spot == 3
          result[1] = 6 + place.side*2 + 1
        elsif place.spot == 5
          result[1] = 6 + place.side*2 + 2
          result[1] -= 12 if result[1] > 19
        end
    end
    result.compact
  end

  def get_places_indexes_of_field(index)
    get_field(index)
    (1..54).select { |i| get_fields_indexes_of_place(i).include? index}
  end
end