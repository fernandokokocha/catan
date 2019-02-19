class SetupGame < Controller
  def expected_params
    {
      players: Array
    }
  end

  def validate
    error = validate_params and return error

    return ':players key is empty' if @request[:players].empty?
    return 'Non-unique player names' if duplicates?(player_names)
    return 'Non-unique player colors' if duplicates?(player_colors)
    return 'Illegal color' if player_colors - valid_colors != []

    nil
  end

  def execute
    @response = {}
    @response[:map] = setup_map
    @response[:players] = setup_players
    @response[:current_player] = setup_current_player
    @response[:turn] = 1
    @response
  end

  private

  def setup_map
    Map.new_random
  end

  def setup_players
    players = []
    @request[:players].each do |player|
      players << Player.new(player[:name],
                            player[:color])
    end
    players
  end

  def setup_current_player
    @response[:players].sample
  end

  def valid_colors
    %i[orange red white blue]
  end

  def player_names
    @request[:players].map { |p| p[:name] }
  end

  def player_colors
    @request[:players].map { |p| p[:color] }
  end

  def duplicates?(collection)
    collection.uniq.length != collection.length
  end
end
