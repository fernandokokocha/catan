require 'json'

class Player
  attr_reader :name, :color
  attr_accessor :resources

  def initialize(name, color, resources = {})
    @name = name
    @color = color
    @resources = {}
    %i[ore lumber wool grain brick].each do |resource|
      @resources[resource] = resources[resource] || 0
    end
  end

  def ==(other)
    return false if self.class != other.class
    return false if @name != other.name
    return false if @color != other.color
    return false if @resources != other.resources
    true
  end

  def to_json
    {
      color: @color,
      name: @name,
      resources: @resources
    }.to_json
  end

  def self.from_json(json)
    player_data = JSON.parse(json)
    new(player_data['name'], player_data['color'].to_sym, player_data['resources'].symbolize_keys)
  end
end
