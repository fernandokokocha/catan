require File.join(__dir__, 'entities', 'map', 'settings.rb')
require File.join(__dir__, 'entities', 'map', 'geometry.rb')
require File.join(__dir__, 'entities', 'map', 'map.rb')

Dir[File.join(__dir__, 'entities', '*.rb')].each { |file| require file }

require File.join(__dir__, 'controllers', 'controller.rb')
Dir[File.join(__dir__, 'controllers', '*.rb')].each { |file| require file }

class Catan
  attr_accessor :map, :players, :current_player, :turn
end
