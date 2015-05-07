class Place
  attr_reader :index, :layer, :side, :spot, :settled_by, :roads

  def initialize index
    @index = index
    @roads = []

    case index
      when(1..6)
        @layer = 1
        base = (index - 1)
        @side = 1 + (base / 1)
        @spot = 1 + (base % 1)
      when (7..24)
        @layer = 2
        base = (index - 7)
        @side = 1 + (base / 3)
        @spot = 1 + (base % 3)
      else
        @layer = 3
        base = (index - 25)
        @side = 1 + (base / 5)
        @spot = 1 + (base % 5)
    end
  end

  def settle player
    @settled_by = player
  end

  def add_road neighbour, player
    @roads << [neighbour, player]
  end
end