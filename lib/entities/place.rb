class Place
  attr_reader :index, :layer, :side, :spot, :settled_by, :roads

  def initialize(index)
    @index = index
    @roads = []

    characteristics = calc_characteristics(index)
    @layer = characteristics[:layer]
    @side = 1 + (characteristics[:index_in_layer] / characteristics[:places_per_side])
    @spot = 1 + (characteristics[:index_in_layer] % characteristics[:places_per_side])
  end

  def settle(player)
    @settled_by = player
  end

  def add_road(neighbour, player)
    @roads << [neighbour, player]
  end

  def ==(other)
    return false if self.class != other.class
    return false if @index != other.index
    return false if @layer != other.layer
    return false if @side != other.side
    return false if @spot != other.spot
    compare_roads(other)
  end

  private

  def calc_characteristics(index)
    case index
    when (1..6)
      { layer: 1, index_in_layer: index - 1, places_per_side: 1 }
    when (7..24)
      { layer: 2, index_in_layer: index - 7, places_per_side: 3 }
    else
      { layer: 3, index_in_layer: index - 25, places_per_side: 5 }
    end
  end

  def compare_roads(other)
    @roads.each.with_index do |road, i|
      return false if road[0] != other.roads[i][0]
      return false if road[1] != other.roads[i][1]
    end
    true
  end
end
