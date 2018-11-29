class Settings
  def layers_count
    3
  end

  def max_field_index
    (1+6+12)
  end

  def max_place_index
    layers_count * layers_count * 6
  end

  def numbers_dist
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

  def resources_dist
    Array.new(3, :ore) +
        Array.new(3, :brick) +
        Array.new(4, :wool) +
        Array.new(4, :grain) +
        Array.new(4, :lumber)
  end
end
