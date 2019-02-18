require File.join(__dir__, 'entities', 'map', 'settings.rb')
require File.join(__dir__, 'entities', 'map', 'geometry.rb')
require File.join(__dir__, 'entities', 'map', 'map.rb')

Dir[File.join(__dir__, 'entities', '*.rb')].each { |file| require file }

require File.join(__dir__, 'controllers', 'controller.rb')
Dir[File.join(__dir__, 'controllers', '*.rb')].each { |file| require file }

class Catan
  attr_accessor :map, :players, :current_player, :turn

  def ==(other)
    return false if self.class != other.class
    return false if @map != other.map
    return false if @players != other.players
    return false if @current_player != other.current_player
    return false if @turn != other.turn
    true
  end
end
