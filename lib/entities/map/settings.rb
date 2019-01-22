class Settings
  def layers_count
    3
  end

  def max_field_index
    (1 + 6 + 12)
  end

  def max_place_index
    layers_count * layers_count * 6
  end

  def numbers_dist
    [2] +
      ((3..6).to_a * 2) +
      ((8..11).to_a * 2) +
      [12]
  end

  def resources_dist
    Array.new(3, :ore) +
      Array.new(3, :brick) +
      Array.new(4, :wool) +
      Array.new(4, :grain) +
      Array.new(4, :lumber)
  end
end
