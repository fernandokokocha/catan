class SetupGame
  def initialize request
    @request = request
  end

  def invoke
    raise InvalidParameters unless valid?
    @map = setup_map
    @players = setup_players
    @order = setup_order
    [@map, @players, @order]
  end

  class InvalidParameters < StandardError
  end

  private
  def setup_map
    Map.new(@request[:layers_count])
  end

  def setup_players
    players = []
    @request[:players].each do |player|
      players << Player.new(player[:name],
                            player[:color])
    end
    players
  end

  def setup_order
    @players.shuffle
  end

  def valid?
    return false unless @request.is_a?(Hash)

    return false unless @request.has_key?(:layers_count)
    return false if @request[:layers_count] <= 0

    return false unless @request.has_key?(:players)
    return false unless @request[:players].is_a?(Array)
    return false if @request[:players].empty?

    return false if has_duplicates(player_names)
    return false if has_duplicates(player_colors)
    return false if player_colors - legal_colors != []

    true
  end

  def legal_colors
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