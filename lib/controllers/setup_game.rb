require_relative 'controller'

class SetupGame < Controller
  def execute
    @response = {}
    @response[:map] = setup_map
    @response[:players] = setup_players
    @response[:current_player] = setup_current_player
    @response[:turn] = 1
    @response
  end

  def valid?
    return false unless @request.is_a?(Hash)

    return false unless @request.has_key?(:layers_count)
    return false unless @request.has_key?(:players)

    layers_count = @request[:layers_count]
    players = @request[:players]

    return false if layers_count <= 0
    return false unless players.is_a?(Array)
    return false if players.empty?
    return false if has_duplicates(player_names)
    return false if has_duplicates(player_colors)
    return false if player_colors - valid_colors != []

    true
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

  def has_duplicates(player_names)
    player_names.uniq.length != player_names.length
  end
end