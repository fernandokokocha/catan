require_relative 'controller'

class SetupGame < Controller
  def invoke
    error = validate
    if error
      raise InvalidParameters.new(error)
    else
      execute
    end
  end

  def execute
    @response = {}
    @response[:map] = setup_map
    @response[:players] = setup_players
    @response[:current_player] = setup_current_player
    @response[:turn] = 1
    @response
  end

  def validate
    return 'Params is not a hash' unless @request.is_a?(Hash)
    return 'Missing :players key in params' unless @request.has_key?(:players)

    players = @request[:players]

    return ':players key is not an array' unless players.is_a?(Array)
    return ":players key is empty" if players.empty?
    return 'Non-unique player names' if has_duplicates(player_names)
    return 'Non-unique player colors' if has_duplicates(player_colors)
    return 'Illegal color' if player_colors - valid_colors != []

    nil
  end

  private
  def setup_map
    Map.new
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
    [:orange, :red, :white, :blue]
  end

  def player_names
    @request[:players].map { |p| p[:name] }
  end

  def player_colors
    @request[:players].map { |p| p[:color] }
  end

  def has_duplicates(collection)
    collection.uniq.length != collection.length
  end
end
