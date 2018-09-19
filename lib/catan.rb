require_relative 'entities/map'
require_relative 'entities/player'
require_relative 'controllers/setup_game'
require_relative 'controllers/end_turn'
require_relative 'controllers/settle_with_road'
require_relative 'controllers/gain_resources_around_settlement'

class Catan
  attr_accessor :map, :players, :current_player, :turn
end
