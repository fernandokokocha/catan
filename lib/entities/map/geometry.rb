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
  PLACES_CIRCUIT_PER_LAYER = [nil, 6, 18, 30].freeze
  MAX_PLACE_INDEX_PER_LAYER = [nil, 6, 24, 54].freeze
  
  FIELDS_CIRCUIT_PER_LAYER = [nil, 1, 6, 12].freeze
  MAX_FIELD_INDEX_PER_PLAYER = [nil, 1, 7, 19].freeze

  def get_neighbours_indexes(place)
    GetNeighboursIndexes.call(place)
  end

  def get_fields_indexes_of_place(place)
    GetFieldsIndexesOfPlace.call(place)
  end

  class GetNeighboursIndexes
    def self.call(place)
      new.call(place)
    end

    def call(place)
      index = place.index
      layer = place.layer

      places_circuit = PLACES_CIRCUIT_PER_LAYER[layer]
      max_place_index = MAX_PLACE_INDEX_PER_LAYER[layer]

      [
        calc_forward_neighbour_from_same_layer(index, places_circuit, max_place_index),
        calc_backward_neighbour_from_same_layer(index, places_circuit, max_place_index),
        calc_neighbour_from_other_layer(index, place)
      ].compact
    end

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
      return MAX_PLACE_INDEX_PER_LAYER[2] if index == 1
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
      result += PLACES_CIRCUIT_PER_LAYER[3] if result <= MAX_PLACE_INDEX_PER_LAYER[2]
      result
    end

    def calc_neighbour_for_layer_2_from_layer_1(place)
      result = (place.index / 3) - 1
      result -= PLACES_CIRCUIT_PER_LAYER[1] if result > MAX_PLACE_INDEX_PER_LAYER[1]
      result
    end

    def calc_neighbour_for_layer_3(place)
      return nil unless [3, 5].include?(place.spot)

      result = 2 + place.spot + place.side * 3
      result -= PLACES_CIRCUIT_PER_LAYER[2] if result > MAX_PLACE_INDEX_PER_LAYER[2]
      result
    end
  end

  class GetFieldsIndexesOfPlace
    def self.call(place)
      new.call(place)
    end

    def call(place)
      case place.layer
      when 1
        calc_fields_for_layer_1(place)
      when 2
        calc_fields_for_layer_2(place)
      else
        calc_fields_for_layer_3(place)
      end
    end

    def calc_fields_for_layer_1(place)
      [
        calc_field_from_lower_layer(place),
        place.index == 1 ? 7 : place.index,
        place.index + 1
      ]
    end

    def calc_fields_for_layer_2(place)
      result = Array.new(3)
      result[0] = calc_field_from_lower_layer(place)
      result[1] = calc_field_from_higher_layer(place)

      result[2] = if [1, 2].include? place.spot
                    calc_next_forward_field(result[1], 3)
                  else
                    calc_next_forward_field(result[0], 2)
                  end
      result
    end

    def calc_fields_for_layer_3(place)
      result = [calc_field_from_lower_layer(place)]
      result << calc_next_forward_field(result[0], 3) if [3, 5].include? place.spot
      result
    end

    def calc_field_from_lower_layer(place)
      base = place.layer < 3 ? 1 : 6
      result = base + place.side * (place.layer - 1)
      result += 1 if place.spot > 3
      result
    end

    def calc_field_from_higher_layer(place)
      result = place.index - place.side + 1
      result += 12 if result <= 7
      result
    end

    def calc_next_forward_field(field_index, layer)
      result = field_index + 1
      result -= FIELDS_CIRCUIT_PER_LAYER[layer] if result > MAX_FIELD_INDEX_PER_PLAYER[layer]
      result
    end
  end
end
