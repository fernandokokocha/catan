require_relative 'controller'

class EndTurn < Controller
  def invoke
    raise InvalidParameters unless valid?
  end
  
  def valid?
    return false if @request.nil?
    return false unless @request.is_a?(Hash)
    return false unless @request.has_key?(:turn)
    return false unless @request.has_key?(:players)
    return false unless @request.has_key?(:current_player)

    return false unless @request[:turn].is_a?(Fixnum)
    return false unless @request[:players].is_a?(Array)
    return false if @request[:players].empty?
    @request[:players].each do |player|
      return false unless player.is_a?(Player)
    end
    return false unless @request[:current_player].is_a?(Player)
    return false unless @request[:players].include? @request[:current_player]

    true
  end
end