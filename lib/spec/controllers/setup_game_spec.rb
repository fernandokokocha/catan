require 'spec_helper'

describe SetupGame do
  let(:valid_players) { [{:name => 'Bartek',
                          :color => :orange}] }
  let(:valid_layers_count) { 3 }
  let(:valid_request) { {:players => valid_players,
                         :layers_count => valid_layers_count} }

  it 'raises error if request is nil' do
    request = nil
    expect{ SetupGame.new(request).invoke }.to raise_error(Controller::InvalidParameters)
  end

  it 'raises error if request is not a hash' do
    request = []
    expect{ SetupGame.new(request).invoke }.to raise_error(Controller::InvalidParameters)
  end

  it 'requires layers_count' do
    request = valid_request
    request.delete(:layers_count)
    expect{ SetupGame.new(request).invoke }.to raise_error(Controller::InvalidParameters)
  end

  it 'raises error if layers count is a zero' do
    request = valid_request
    request[:layers_count] = 0
    expect{ SetupGame.new(request).invoke }.to raise_error(Controller::InvalidParameters)
  end

  it 'raises error if layers count is a negative number' do
    request = valid_request
    request[:layers_count] = -1
    expect{ SetupGame.new(request).invoke }.to raise_error(Controller::InvalidParameters)
  end

  it 'requires players' do
    request = valid_request
    request.delete(:players)
    expect{ SetupGame.new(request).invoke }.to raise_error(Controller::InvalidParameters)
  end

  it 'raises error if players is not an array' do
    request = valid_request
    request[:players] = 2
    expect{ SetupGame.new(request).invoke }.to raise_error(Controller::InvalidParameters)
  end

  it 'raises error if players is empty array' do
    request = valid_request
    request[:players] = []
    expect{ SetupGame.new(request).invoke }.to raise_error(Controller::InvalidParameters)
  end

  it 'raises error if players have the same name' do
    players = []
    players << {:name => 'Bartek',
                :color => :orange}
    players << {:name => 'Bartek',
                :color => :red}
    request = valid_request
    request[:players] = players
    expect{ SetupGame.new(request).invoke }.to raise_error(Controller::InvalidParameters)
  end

  it 'raises error if players have the same color' do
    players = []
    players << {:name => 'Bartek',
                :color => :orange}
    players << {:name => 'John',
                :color => :orange}
    request = valid_request
    request[:players] = players
    expect{ SetupGame.new(request).invoke }.to raise_error(Controller::InvalidParameters)
  end

  it 'raises error if player has illegal color' do
    players = []
    players << {:name => 'Bartek',
                :color => :yellow}
    request = valid_request
    request[:players] = players
    expect{ SetupGame.new(request).invoke }.to raise_error(Controller::InvalidParameters)
  end

  it 'raises error if more than 4 players' do
    players = []
    players << {:name => 'Bartek',
                :color => :orange}
    players << {:name => 'John',
                :color => :red}
    players << {:name => 'Mark',
                :color => :white}
    players << {:name => 'Wojtas',
                :color => :blue}
    players << {:name => 'Marcin',
                :color => :white}
    request = valid_request
    request[:players] = players
    expect{ SetupGame.new(request).invoke }.to raise_error(Controller::InvalidParameters)
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

    it 'returns map with as many layers as specified' do
      expect(@map.layers_count).to eq(valid_layers_count)
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

      it 'sets player zero ore' do
        expect(@players[0].resources[:ore]).to eq(0)
      end

      it 'sets player zero brick' do
        expect(@players[0].resources[:brick]).to eq(0)
      end

      it 'sets player zero lumber' do
        expect(@players[0].resources[:lumber]).to eq(0)
      end

      it 'sets player zero grain' do
        expect(@players[0].resources[:grain]).to eq(0)
      end

      it 'sets player zero wool' do
        expect(@players[0].resources[:wool]).to eq(0)
      end
    end

    context 'with two players' do
      before (:each) do
        @valid_players = valid_players
        @valid_players << {:name => 'John',
                           :color => :red}
        @request = valid_request
        @request[:players] = @valid_players
        @response = SetupGame.new(@request).invoke
        @map = @response[:map]
        @players = @response[:players]
        @current_player = @response[:current_player]
      end

      it 'returns two players' do
        expect(@players.length).to eq(2)
      end

      it 'sets two players names respectively' do
        expect(@players[0].name).to eq(@valid_players[0][:name])
        expect(@players[1].name).to eq(@valid_players[1][:name])
      end

      it 'sets two players colors respectively' do
        expect(@players[0].color).to eq(@valid_players[0][:color])
        expect(@players[1].color).to eq(@valid_players[1][:color])
      end

      it 'sets both players zero ore' do
        expect(@players[0].resources[:ore]).to eq(0)
        expect(@players[1].resources[:ore]).to eq(0)
      end

      it 'sets both players zero brick' do
        expect(@players[0].resources[:brick]).to eq(0)
        expect(@players[1].resources[:brick]).to eq(0)
      end

      it 'sets both players zero lumber' do
        expect(@players[0].resources[:lumber]).to eq(0)
        expect(@players[1].resources[:lumber]).to eq(0)
      end

      it 'sets both players zero grain' do
        expect(@players[0].resources[:grain]).to eq(0)
        expect(@players[1].resources[:grain]).to eq(0)
      end

      it 'sets both players zero wool' do
        expect(@players[0].resources[:wool]).to eq(0)
        expect(@players[1].resources[:wool]).to eq(0)
      end
    end

    context 'with four players' do
      before (:each) do
        @valid_players = valid_players
        @valid_players << {:name => 'John',
                           :color => :red}
        @valid_players << {:name => 'Mark',
                           :color => :white}
        @valid_players << {:name => 'Wojtas',
                           :color => :blue}
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

      it 'sets four players names respectively' do
        expect(@players[0].name).to eq(@valid_players[0][:name])
        expect(@players[1].name).to eq(@valid_players[1][:name])
        expect(@players[2].name).to eq(@valid_players[2][:name])
        expect(@players[3].name).to eq(@valid_players[3][:name])
      end

      it 'sets four players colors respectively' do
        expect(@players[0].color).to eq(@valid_players[0][:color])
        expect(@players[1].color).to eq(@valid_players[1][:color])
        expect(@players[2].color).to eq(@valid_players[2][:color])
        expect(@players[3].color).to eq(@valid_players[3][:color])
      end

      it 'sets all players zero ore' do
        expect(@players[0].resources[:ore]).to eq(0)
        expect(@players[1].resources[:ore]).to eq(0)
        expect(@players[2].resources[:ore]).to eq(0)
        expect(@players[3].resources[:ore]).to eq(0)
      end

      it 'sets all players zero brick' do
        expect(@players[0].resources[:brick]).to eq(0)
        expect(@players[1].resources[:brick]).to eq(0)
        expect(@players[2].resources[:brick]).to eq(0)
        expect(@players[3].resources[:brick]).to eq(0)
      end

      it 'sets all players zero lumber' do
        expect(@players[0].resources[:lumber]).to eq(0)
        expect(@players[1].resources[:lumber]).to eq(0)
        expect(@players[2].resources[:lumber]).to eq(0)
        expect(@players[3].resources[:lumber]).to eq(0)
      end

      it 'sets all players zero grain' do
        expect(@players[0].resources[:grain]).to eq(0)
        expect(@players[1].resources[:grain]).to eq(0)
        expect(@players[2].resources[:grain]).to eq(0)
        expect(@players[3].resources[:grain]).to eq(0)
      end

      it 'sets all players zero wool' do
        expect(@players[0].resources[:wool]).to eq(0)
        expect(@players[1].resources[:wool]).to eq(0)
        expect(@players[2].resources[:wool]).to eq(0)
        expect(@players[3].resources[:wool]).to eq(0)
      end
    end
  end
end