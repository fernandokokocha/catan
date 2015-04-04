require_relative 'entities/map.rb'

class Catan
  attr_accessor :map

  def initialize
    @map = Map.new(3)
  end
end