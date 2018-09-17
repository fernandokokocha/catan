describe SetupGame do
  let(:valid_player) { {name: 'Bartek', color: :orange} }
  let(:valid_players) { [valid_player] }
  let(:valid_request) { {players: valid_players} }

  it 'raises error if request is nil' do
    request = nil
    expect{ SetupGame.new(request).invoke }.to raise_error(
      Controller::InvalidParameters,
      'Params is not a hash'
    )
  end

  it 'raises error if request is not a hash' do
    request = []
    expect{ SetupGame.new(request).invoke }.to raise_error(
      Controller::InvalidParameters,
      'Params is not a hash'
    )
  end

  it 'requires players' do
    request = valid_request
    request.delete(:players)
    expect{ SetupGame.new(request).invoke }.to raise_error(
      Controller::InvalidParameters,
      'Missing :players key in params'
    )
  end

  it 'raises error if players is not an array' do
    request = valid_request
    request[:players] = 2
    expect{ SetupGame.new(request).invoke }.to raise_error(
      Controller::InvalidParameters,
      ':players key is not an array'
    )
  end

  it 'raises error if players is empty array' do
    request = valid_request
    request[:players] = []
    expect{ SetupGame.new(request).invoke }.to raise_error(
      Controller::InvalidParameters,
      ":players key is empty"
    )
  end

  it 'raises error if players have the same name' do
    players = []
    players << {:name => 'Bartek', :color => :orange}
    players << {:name => 'Bartek', :color => :red}
    request = valid_request
    request[:players] = players
    expect{ SetupGame.new(request).invoke }.to raise_error(
      Controller::InvalidParameters,
      'Non-unique player names'
    )
  end

  it 'raises error if players have the same color' do
    players = []
    players << {:name => 'Bartek', :color => :orange}
    players << {:name => 'John', :color => :orange}
    request = valid_request
    request[:players] = players
    expect{ SetupGame.new(request).invoke }.to raise_error(
      Controller::InvalidParameters,
      'Non-unique player colors'
    )
  end

  it 'raises error if player has illegal color' do
    players = []
    players << {:name => 'Bartek',:color => :yellow}
    request = valid_request
    request[:players] = players
    expect{ SetupGame.new(request).invoke }.to raise_error(
      Controller::InvalidParameters,
      'Illegal color'
    )
  end

  it 'raises error if more than 4 players' do
    players = []
    players << {:name => 'Bartek', :color => :orange}
    players << {:name => 'John', :color => :red}
    players << {:name => 'Mark', :color => :white}
    players << {:name => 'Wojtas', :color => :blue}
    players << {:name => 'Marcin', :color => :green}
    request = valid_request
    request[:players] = players
    expect{ SetupGame.new(request).invoke }.to raise_error(
      Controller::InvalidParameters,
      'Illegal color'
    )
  end

  context 'when valid request' do
    before(:each) do
      @request = valid_request
      @response = SetupGame.new(@request).invoke
      @map = @response[:map]
      @players = @response[:players]
      @current_player = @response[:current_player]
      @turn = @response[:turn]
    end

    it 'returns map' do
      expect(@map).to be_instance_of Map
    end

    it 'returns map with 3 layers' do
      expect(@map.layers_count).to eq(3)
    end

    it 'returns players' do
      expect(@players).not_to be_empty
      @players.each do |user|
        expect(user).to be_instance_of Player
      end
    end

    it 'returns current_player as player' do
      expect(@current_player).to be_instance_of Player
    end

    it 'returns current_player from players' do
      expect(@players).to include @current_player
    end

    it 'returns first turn' do
      expect(@turn).to eq(1)
    end

    context 'with one player' do
      it 'return one player' do
        expect(@players.length).to eq(1)
      end

      it 'sets player name' do
        expect(@players[0].name).to eq(valid_players[0][:name])
      end

      it 'sets player color' do
        expect(@players[0].color).to eq(valid_players[0][:color])
      end

      RESOURCE_NAMES.each do |resource_name|
        it "sets player zero #{resource_name}" do
          expect(@players[0].resources[resource_name]).to eq(0)
        end
      end

    end

    context 'with four players' do
      before (:each) do
        @valid_players = valid_players
        @valid_players << {:name => 'John', :color => :red}
        @valid_players << {:name => 'Mark', :color => :white}
        @valid_players << {:name => 'Wojtas', :color => :blue}
        @request = valid_request
        @request[:players] = @valid_players
        @response = SetupGame.new(@request).invoke
        @map = @response[:map]
        @players = @response[:players]
        @current_player = @response[:current_player]
      end

      it 'returns four players' do
        expect(@players.length).to eq(4)
      end

      it 'sets each players thier names respectively' do
        (0..3).each do |index|
          expect(@players[index].name).to eq(@valid_players[index][:name])
        end
      end

      it 'sets each players thier colors respectively' do
        (0..3).each do |index|
          expect(@players[index].color).to eq(@valid_players[index][:color])
        end
      end

      RESOURCE_NAMES.each do |resource_name|
        it "sets each player zero #{resource_name}" do
          (0..3).each do |index|
            expect(@players[index].resources[resource_name]).to eq(0)
          end
        end
      end
    end
  end
end
