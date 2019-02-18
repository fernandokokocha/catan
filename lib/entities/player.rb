class Player
  attr_reader :name, :color
  attr_accessor :resources

  def initialize(name, color)
    @name = name
    @color = color
    @resources = {}
    %i[ore lumber wool grain brick].each do |resource|
      @resources[resource] = 0
    end
  end

  def ==(other)
    return false if self.class != other.class
    return false if @name != other.name
    return false if @color != other.color
    return false if @resources != other.resources
    true
  end
end
