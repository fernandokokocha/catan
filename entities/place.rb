class Place
  attr_accessor :index, :layer, :side, :spot

  def initialize index
    @index = index

    if index <= 6
      @layer = 1
      base = (index - 1)
      @side = 1 + (base / 1)
      @spot = 1+  (base % 1)
    elsif index <= 24
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
end