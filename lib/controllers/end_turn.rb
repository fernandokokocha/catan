require_relative 'controller'

class EndTurn < Controller
  def execute
    index = @request[:players].index(@request[:current_player])
    len = @request[:players].length
    if @request[:turn].between?(len+1, 2*len-1)
      @request[:current_player] = @request[:players][(index - 1) % len]
    elsif @request[:turn] != len
      @request[:current_player] = @request[:players][(index + 1) % len]
    end
    @request[:turn] += 1
  end

  def valid?
    return false if @request.nil?
    return false unless @request.is_a?(Hash)
    return false unless @request.has_key?(:turn)
    return false unless @request.has_key?(:players)
    return false unless @request.has_key?(:current_player)

    return false unless @request[:turn].is_a?(Integer)
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
