class Map
  attr_accessor :places, :fields, :settings, :geometry

  def initialize
    @settings = Settings.new
    @geometry = Geometry.new
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

    place = place(index)
    geometry.get_neighbours_indexes(place).map { |i| place(i) }
  end

  def get_fields_of_place(index)
    raise WrongIndexError unless index.is_a?(Integer)
    raise WrongIndexError unless index.between?(1, @places.count)

    place = place(index)
    geometry.get_fields_indexes_of_place(place).map { |i| field(i) }
  end

  def get_places_of_field(index)
    raise WrongIndexError unless index.is_a?(Integer)
    raise WrongIndexError unless index.between?(1, @fields.count)

    field(index)
    @places.select { |place| geometry.get_fields_indexes_of_place(place).include?(index) }
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

  def ==(other)
    return false if self.class != other.class
    @places.each.with_index { |place, i| return false if place != other.places[i] }
    @fields.each.with_index { |field, i| return false if field != other.fields[i] }
    true
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
    resources = settings.resources_dist.shuffle
    numbers = settings.numbers_dist.shuffle

    desert = Field.new(1, :desert, 7)
    regular_fields = (2..max).zip(resources, numbers).map do |index, resource, number|
      Field.new(index, resource, number)
    end
    [desert] + regular_fields
  end
end
