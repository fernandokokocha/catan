describe 'Game serialization' do
  let(:setup_game) do
    valid_player = { name: 'Bartek', color: :orange }
    valid_players = [valid_player]
    request = { players: valid_players }

    SetupGame.new(request)
  end

  it 'can store and load games' do
    game = Catan.new
    setup_data = setup_game.invoke
    game.map = setup_data[:map]
    game.players = setup_data[:players]
    game.current_player = setup_data[:current_player]
    game.turn = setup_data[:turn]

    request = { game: game }
    serialized = SerializeGame.new(request).invoke

    request = { dump: serialized }
    deserialized = DeserializeGame.new(request).invoke

    expect(game).to eq(deserialized)
  end
end
