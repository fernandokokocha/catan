class Place
  attr_accessor :index, :layer, :side, :spot

  def initialize index
    self.index = index

    if index <= 6
      self.layer = 1
      base = (index - 1)
      self.side = 1 + (base / 1)
      self.spot = 1+  (base % 1)
    elsif index <= 24
      self.layer = 2
      base = (index - 7)
      self.side = 1 + (base / 3)
      self.spot = 1 + (base % 3)
    else
      self.layer = 3
      base = (index - 25)
      self.side = 1 + (base / 5)
      self.spot = 1 + (base % 5)
    end

  end
end