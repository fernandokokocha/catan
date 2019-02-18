class Field
  attr_reader :index, :resource, :number

  def initialize(index, resource, number)
    @index = index
    @resource = resource
    @number = number
  end

  def ==(other)
    return false if self.class != other.class
    return false if @index != other.index
    return false if @resource != other.resource
    return false if @number != other.number
    true
  end
end
