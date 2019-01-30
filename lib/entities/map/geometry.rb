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

class Geometry
  CIRCUIT_OF_LAYER = [nil, 6, 18, 30].freeze
  LAYER_LIMIT_PER_LAYER = [nil, 6, 24, 54].freeze

  def get_neighbours_indexes(place)
    index = place.index
    layer = place.layer

    [
      calc_forward_neighbour_from_same_layer(index, CIRCUIT_OF_LAYER[layer], LAYER_LIMIT_PER_LAYER[layer]),
      calc_backward_neighbour_from_same_layer(index, CIRCUIT_OF_LAYER[layer], LAYER_LIMIT_PER_LAYER[layer]),
      calc_neighbour_from_other_layer(index, place)
    ].compact
  end

  def get_fields_indexes_of_place(place)
    index = place.index

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

  private

  def calc_forward_neighbour_from_same_layer(index, circuit, layer_limit)
    result =  index + 1
    result -= circuit if result > layer_limit
    result
  end

  def calc_backward_neighbour_from_same_layer(index, circuit, layer_limit)
    result =  index + circuit - 1
    result -= circuit if result > layer_limit
    result
  end

  def calc_neighbour_from_other_layer(index, place)
    case place.layer
    when 1
      calc_neighbour_for_layer_1(index)
    when 2
      calc_neighbour_for_layer_2(place)
    else
      calc_neighbour_for_layer_3(place)
    end
  end

  def calc_neighbour_for_layer_1(index)
    return LAYER_LIMIT_PER_LAYER[2] if index == 1
    (index + 1) * 3
  end

  def calc_neighbour_for_layer_2(place)
    if [1, 2].include? place.spot
      calc_neighbour_for_layer_2_from_layer_3(place)
    else
      calc_neighbour_for_layer_2_from_layer_1(place)
    end
  end

  def calc_neighbour_for_layer_2_from_layer_3(place)
    result = 7 - place.side * 4 + place.index * 3
    result += CIRCUIT_OF_LAYER[3] if result <= LAYER_LIMIT_PER_LAYER[2]
    result
  end

  def calc_neighbour_for_layer_2_from_layer_1(place)
    result = (place.index / 3) - 1
    result -= CIRCUIT_OF_LAYER[1] if result > LAYER_LIMIT_PER_LAYER[1]
    result
  end

  def calc_neighbour_for_layer_3(place)
    return nil unless [3, 5].include?(place.spot)

    result = 2 + place.spot + place.side * 3
    result -= CIRCUIT_OF_LAYER[2] if result > LAYER_LIMIT_PER_LAYER[2]
    result
  end
end
