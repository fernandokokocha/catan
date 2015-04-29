class Field
  attr_reader :index, :resource

  def initialize index
    @index = index
    @resource = (index == 1) ? :desert : :ore
  end
end