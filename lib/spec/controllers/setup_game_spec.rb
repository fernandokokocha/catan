require 'spec_helper'

describe SetupGame do
  let(:valid_players) { [{:name => 'Bartek',
                          :color => :orange}] }
  let(:valid_layers_count) { 3 }

  it 'raises error if passed nil' do
    request = nil
    expect{ SetupGame.new(request).invoke }.to raise_error(SetupGame::InvalidParameters)
  end

  it 'raises error if request is not a hash' do
    request = []
    expect{ SetupGame.new(request).invoke }.to raise_error(SetupGame::InvalidParameters)
  end

  it 'requires layers_count' do
    request = {:players => valid_players}
    expect{ SetupGame.new(request).invoke }.to raise_error(SetupGame::InvalidParameters)
  end

  it 'raises error if layers count is a zero' do
    request = {:layers_count => 0}
    expect{ SetupGame.new(request).invoke }.to raise_error(SetupGame::InvalidParameters)
  end

  it 'raises error if layers count is a negative number' do
    request = {:layers_count => -1}
    expect{ SetupGame.new(request).invoke }.to raise_error(SetupGame::InvalidParameters)
  end

  it 'requires players' do
    request = {:layers_count => valid_layers_count}
    expect{ SetupGame.new(request).invoke }.to raise_error(SetupGame::InvalidParameters)
  end

  it 'raises error if players is not an array' do
    @players = 2
    request = {:layers_count => valid_layers_count,
               :players => @players}
    expect{ SetupGame.new(request).invoke }.to raise_error(SetupGame::InvalidParameters)
  end

  it 'raises error if players is empty array' do
    @players = []
    request = {:layers_count => valid_layers_count,
               :players => @players}
    expect{ SetupGame.new(request).invoke }.to raise_error(SetupGame::InvalidParameters)
  end

  it 'raises error if players have the same name' do
    @players = []
    @players << {:name => 'Bartek',
                 :color => :orange}
    @players << {:name => 'Bartek',
                 :color => :red}
    request = {:layers_count => valid_layers_count,
               :players => @players}
    expect{ SetupGame.new(request).invoke }.to raise_error(SetupGame::InvalidParameters)
  end

  it 'raises error if players have the same color' do
    @players = []
    @players << {:name => 'Bartek',
                 :color => :orange}
    @players << {:name => 'John',
                 :color => :orange}
    request = {:layers_count => valid_layers_count,
               :players => @players}
    expect{ SetupGame.new(request).invoke }.to raise_error(SetupGame::InvalidParameters)
  end

  it 'raises error if player has illegal color' do
    @players = []
    @players << {:name => 'Bartek',
                 :color => :yellow}
    request = {:layers_count => valid_layers_count,
               :players => @players}
    expect{ SetupGame.new(request).invoke }.to raise_error(SetupGame::InvalidParameters)
  end

  it 'raises error if more than 4 players' do
    @players = []
    @players << {:name => 'Bartek',
                 :color => :orange}
    @players << {:name => 'John',
                 :color => :red}
    @players << {:name => 'Mark',
                 :color => :white}
    @players << {:name => 'Wojtas',
                 :color => :blue}
    @players << {:name => 'Marcin',
                 :color => :white}
    request = {:layers_count => valid_layers_count,
               :players => @players}
    expect{ SetupGame.new(request).invoke }.to raise_error(SetupGame::InvalidParameters)
  end

  describe 'when valid request' do
    before(:each) do
      @request = {:layers_count => valid_layers_count,
                  :players => valid_players}
      @map, @players, @order = SetupGame.new(@request).invoke
    end

    it 'returns a three-tuple' do
      expect(@map).to be_truthy
      expect(@players).to be_truthy
      expect(@order).to be_truthy
    end

    it 'returns map as first element' do
      expect(@map).to be_instance_of Map
    end

    it 'returns map with as many layers as specified' do
      expect(@map.layers_count).to eq(valid_layers_count)
    end

    it 'returns list of players as second element' do
      expect(@players).not_to be_empty
      @players.each do |user|
        expect(user).to be_instance_of Player
      end
    end

    it 'returns list of players as third element' do
      expect(@order).not_to be_empty
      @order.each do |user|
        expect(user).to be_instance_of Player
      end
    end

    it 'returns order of players' do
      @order.each do |user|
        expect(@players).to include user
      end
    end

    it 'returns order of uniq players' do
      expect(@order).to eq(@order.uniq)
    end

    describe 'with one player' do
      it 'return one player if specified' do
        expect(@players.length).to eq(1)
      end

      it 'sets player name' do
        expect(@players[0].name).to eq(valid_players[0][:name])
      end

      it 'sets player color' do
        expect(@players[0].color).to eq(valid_players[0][:color])
      end

      it 'returns order of player' do
        expect(@order).to eq(@players)
      end
    end

    describe 'with two players' do
      before (:each) do
        @valid_players = valid_players
        @valid_players << {:name => 'John',
                           :color => :red}
        @request = {:layers_count => valid_layers_count,
                    :players => @valid_players}
        @map, @players, @order = SetupGame.new(@request).invoke
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

      it 'returns list of players as third element' do
        expect(@order).not_to be_empty
        @order.each do |user|
          expect(user).to be_instance_of Player
        end
      end

      it 'returns order of players' do
        @order.each do |user|
          expect(@players).to include user
        end
      end

      it 'returns order of uniq players' do
        expect(@order).to eq(@order.uniq)
      end
    end

    describe 'with four players' do
      before (:each) do
        @valid_players = valid_players
        @valid_players << {:name => 'John',
                           :color => :red}
        @valid_players << {:name => 'Mark',
                           :color => :white}
        @valid_players << {:name => 'Wojtas',
                           :color => :blue}
        @request = {:layers_count => valid_layers_count,
                    :players => @valid_players}
        @map, @players, @order = SetupGame.new(@request).invoke
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

      it 'returns list of players as third element' do
        expect(@order).not_to be_empty
        @order.each do |user|
          expect(user).to be_instance_of Player
        end
      end

      it 'returns order of players' do
        @order.each do |user|
          expect(@players).to include user
        end
      end

      it 'returns order of uniq players' do
        expect(@order).to eq(@order.uniq)
      end
    end
  end
end