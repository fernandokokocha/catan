Dir[File.join(__dir__, 'entities', 'map', 'settings.rb')].each { |file| require file }
Dir[File.join(__dir__, 'entities', 'map', 'map.rb')].each { |file| require file }

Dir[File.join(__dir__, 'entities', '*.rb')].each { |file| require file }

require File.join(__dir__, 'controllers', 'controller.rb')
Dir[File.join(__dir__, 'controllers', '*.rb')].each { |file| require file }

class Catan
  attr_accessor :map, :players, :current_player, :turn
end
