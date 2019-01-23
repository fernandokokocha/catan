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
  def get_neighbours_indexes(place)
    index = place.index

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
end
