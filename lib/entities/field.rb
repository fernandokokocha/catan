class Field
  attr_reader :index, :resource, :number

  def initialize(index, resource, number)
    @index = index
    @resource = resource
    @number = number
  end
end
