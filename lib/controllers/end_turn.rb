class EndTurn < Controller
  def validate
    return 'Params is not a hash' unless @request.is_a?(Hash)
    return 'Missing :turn key in params' unless @request.has_key?(:turn)
    return 'Missing :players key in params' unless @request.has_key?(:players)
    return 'Missing :current_player key in params' unless @request.has_key?(:current_player)

    return ':turn value is not an Integer' unless @request[:turn].is_a?(Integer)
    return ':players value is not an array' unless @request[:players].is_a?(Array)
    return ':players value is empty array' if @request[:players].empty?
    @request[:players].each do |player|
      return 'Illegal entry in :players value' unless player.is_a?(Player)
    end
    return ':current_player value is not a Player' unless @request[:current_player].is_a?(Player)
    return 'Current player not present in players list' unless @request[:players].include? @request[:current_player]

    nil
  end

  def execute
    @players_count = @request[:players].length
    @current_player_index = @request[:players].index(@request[:current_player])
    {
        turn: @request[:turn] + 1,
        current_player: next_player
    }
  end

  def next_player
    return same_player if turn_returning?
    return next_player_backwards if turn_going_backwards?
    next_player_forwards
  end

  def turn_returning?
    @request[:turn] == @players_count
  end

  def turn_going_backwards?
    @request[:turn].between?(@players_count+1, 2*@players_count-1)
  end

  def next_player_forwards
    @request[:players][(@current_player_index + 1) % @players_count]
  end

  def next_player_backwards
    @request[:players][(@current_player_index - 1) % @players_count]
  end

  def same_player
    @request[:current_player]
  end
end
