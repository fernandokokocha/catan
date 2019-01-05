#  Fields' numbers:
#            ____
#       ____╱  8 ╲____
#  ____╱ 19 ╲____╱  9 ╲____
# ╱ 18 ╲____╱  2 ╲____╱ 10 ╲
# ╲____╱  7 ╲____╱  3 ╲____╱
# ╱ 17 ╲____╱  1 ╲____╱ 11 ╲
# ╲____╱  6 ╲____╱  4 ╲____╱
# ╱ 16 ╲____╱  5 ╲____╱ 12 ╲
# ╲____╱ 15 ╲____╱ 13 ╲____╱
#      ╲____╱ 14 ╲____╱
#           ╲____╱
#
# Places' numbers:
#
#                25----26
#                ╱      ╲
#         53----54   8  27----28
#         ╱      ╲      ╱      ╲
#  51----52  19   7---- 8   9  29----30
#  ╱      ╲      ╱      ╲      ╱      ╲
# 50  18  23----24   2   9----10  10  31
#  ╲      ╱      ╲      ╱      ╲      ╱
#  49----22   7   1---- 2   3  11----32
#  ╱      ╲      ╱      ╲      ╱      ╲
# 48  17  21---- 6   1   3----12  11  33
#  ╲      ╱      ╲      ╱      ╲      ╱
#  47----20   6   5---- 4   4  13----34
#  ╱      ╲      ╱      ╲      ╱      ╲
# 46  16  19----18   5  15----14  12  35
#  ╲      ╱      ╲      ╱      ╲      ╱
#  45----44  15  17----16  13  37----36
#         ╲      ╱      ╲      ╱
#         43----42  14  39----38
#                ╲      ╱
#                41----40

class Map
  attr_accessor :places, :fields, :settings

  def initialize
    @settings = Settings.new
    @places = initialize_places
    @fields = initialize_fields
  end

  def place(index)
    raise WrongIndexError unless index.is_a?(Integer)
    raise WrongIndexError unless index.between?(1, @places.count)

    @places[index - 1]
  end

  def field(index)
    raise WrongIndexError unless index.is_a?(Integer)
    raise WrongIndexError unless index.between?(1, @fields.count)

    @fields[index - 1]
  end

  def get_neighbours(index)
    raise WrongIndexError unless index.is_a?(Integer)
    raise WrongIndexError unless index.between?(1, @places.count)

    get_neighbours_indexes(index).map { |i| place(i) }
  end

  def get_fields_of_place(index)
    raise WrongIndexError unless index.is_a?(Integer)
    raise WrongIndexError unless index.between?(1, @places.count)

    get_fields_indexes_of_place(index).map { |i| field(i) }
  end

  def get_places_of_field(index)
    raise WrongIndexError unless index.is_a?(Integer)
    raise WrongIndexError unless index.between?(1, @fields.count)

    get_places_indexes_of_field(index).map { |i| place(i) }
  end

  def places_count
    @places.count
  end

  def fields_count
    @fields.count
  end

  def settle_place(index, player)
    place(index).settle player
  end

  def can_settle?(index)
    return false if place(index).settled_by
    return false if get_neighbours(index).select(&:settled_by).any?

    true
  end

  def build_road(place, neighbour, player)
    place(place).add_road(neighbour, player)
    place(neighbour).add_road(place, player)
  end

  class WrongIndexError < StandardError
  end

  private

  def initialize_places
    max = settings.max_place_index
    (1..max).map { |index| Place.new(index) }
  end

  def initialize_fields
    max = settings.max_field_index
    resources = settings.resources_dist
    numbers = settings.numbers_dist
    fields = []
    fields << Field.new(1, :desert, 7)
    (2..max).each do |index|
      r = resources.shuffle!.pop
      n = numbers.shuffle!.pop
      fields << Field.new(index, r, n)
    end
    fields
  end

  def get_neighbours_indexes(index)
    place = place(index)
    circuit = 6 * (2 * place.layer - 1)
    circuit_sum = 6 * (place.layer * place.layer)

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
      if [1, 2].include? place.spot
        result[2] = 19 + place.side * 5 + (index - (4 + place.side * 3)) * 3
        result[2] += 30 if result[2] < 25
      else
        result[2] = (index - 3) / 3
        result[2] -= 6 if result[2] > 6
      end
    else
      if [3, 5].include? place.spot
        result[2] = 2 + place.spot + place.side * 3
        result[2] -= 18 if result[2] > 24
      end
    end
    result.compact
  end

  def get_fields_indexes_of_place(index)
    place = place(index)

    result = Array.new(3)
    base = place.layer < 3 ? 1 : 6
    result[0] = base + place.side * (place.layer - 1)
    result[0] += 1 if place.spot > 3
    case place.layer
    when 1
      result[1] = index
      result[1] += 6 if result[1] < 2
      result[2] = index + 1
    when 2
      result[1] = index - place.side + 1
      result[1] += 12 if result[1] <= 7

      if [1, 2].include? place.spot
        result[2] = index - place.side + 2
      else
        result[2] = 2 + place.side
        result[2] -= 6 if result[2] > 7
      end
    else
      if place.spot == 3
        result[1] = 6 + place.side * 2 + 1
      elsif place.spot == 5
        result[1] = 6 + place.side * 2 + 2
        result[1] -= 12 if result[1] > 19
      end
    end
    result.compact
  end

  def get_places_indexes_of_field(index)
    field(index)
    (1..@places.count).select { |i| get_fields_indexes_of_place(i).include? index }
  end
end
