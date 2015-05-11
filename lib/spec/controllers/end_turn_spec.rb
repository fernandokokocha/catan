require 'spec_helper'

describe EndTurn do
  let(:valid_turn) { 1 }
  let(:valid_current_player) { Player.new('Bartek', :orange) }
  let(:valid_players) { [valid_current_player,
                         Player.new('Walo', :red)] }
  let(:valid_request) { {:turn => valid_turn,
                         :players => valid_players,
                         :current_player => valid_current_player} }

  it 'raises error if request is nil' do
    request = nil
    expect{ EndTurn.new(request).invoke }.to raise_error(Controller::InvalidParameters)
  end

  it 'raises error if request is not a hash' do
    request = []
    expect{ EndTurn.new(request).invoke }.to raise_error(Controller::InvalidParameters)
  end

  it 'requires turn' do
    request = valid_request
    request.delete(:turn)
    expect{ EndTurn.new(request).invoke }.to raise_error(Controller::InvalidParameters)
  end

  it 'raises error if turn is nil' do
    request = valid_request
    request[:turn] = nil
    expect{ EndTurn.new(request).invoke }.to raise_error(Controller::InvalidParameters)
  end

  it 'raises error if turn is NaN' do
    request = valid_request
    request[:turn] = 'First'
    expect{ EndTurn.new(request).invoke }.to raise_error(Controller::InvalidParameters)
  end

  it 'requires players' do
    request = valid_request
    request.delete(:players)
    expect{ EndTurn.new(request).invoke }.to raise_error(Controller::InvalidParameters)
  end

  it 'raises error if players is nil' do
    request = valid_request
    request[:players] = nil
    expect{ EndTurn.new(request).invoke }.to raise_error(Controller::InvalidParameters)
  end

  it 'raises error if players is not array' do
    request = valid_request
    request[:players] = valid_current_player
    expect{ EndTurn.new(request).invoke }.to raise_error(Controller::InvalidParameters)
  end

  it 'raises error if players is empty array' do
    request = valid_request
    request[:players] = []
    expect{ EndTurn.new(request).invoke }.to raise_error(Controller::InvalidParameters)
  end

  it 'raises error if players contains nil' do
    request = valid_request
    request[:players] = [valid_current_player, nil]
    expect{ EndTurn.new(request).invoke }.to raise_error(Controller::InvalidParameters)
  end

  it 'raises error if players contains not a Player' do
    request = valid_request
    request[:players] = [valid_current_player, "Let me play, I'm a player"]
    expect{ EndTurn.new(request).invoke }.to raise_error(Controller::InvalidParameters)
  end

  it 'requires current_player' do
    request = valid_request
    request.delete(:current_player)
    expect{ EndTurn.new(request).invoke }.to raise_error(Controller::InvalidParameters)
  end

  it 'raises error if current_player is nil' do
    request = valid_request
    request[:current_player] = nil
    expect{ EndTurn.new(request).invoke }.to raise_error(Controller::InvalidParameters)
  end

  it 'raises error if current_player is not a player' do
    request = valid_request
    request[:current_player] = "Let me play, I'm a player"
    expect{ EndTurn.new(request).invoke }.to raise_error(Controller::InvalidParameters)
  end

  it 'raises error if players does not contain current_player' do
    request = valid_request
    request[:current_player] = Player.new('Marcin', :white)
    expect{ EndTurn.new(request).invoke }.to raise_error(Controller::InvalidParameters)
  end

  it 'raises error if current_player is equal not not the same as a player' do
    request = valid_request
    request[:current_player] = Player.new('Bartek', :orange)
    expect{ EndTurn.new(request).invoke }.to raise_error(Controller::InvalidParameters)
  end

  context 'when valid request' do
    before(:each) do
      @request = valid_request
    end

    it 'increments turns' do
      EndTurn.new(@request).invoke
      expect(@request[:turn]).to eq(valid_turn + 1)
    end

    context 'when 2 players' do
      context 'when first turn' do
        it 'makes second player current when first is current' do
          EndTurn.new(@request).invoke
          expect(@request[:current_player]).to be(@request[:players][1])
        end

        it 'makes first player current when second is current' do
          @request[:current_player] = @request[:players][1]
          EndTurn.new(@request).invoke
          expect(@request[:current_player]).to be(@request[:players][0])
        end
      end

      context 'when second turn' do
        before (:each) do
          @request[:turn] = 2
        end

        it 'does not change current first player' do
          EndTurn.new(@request).invoke
          expect(@request[:current_player]).to be(@request[:players][0])
        end

        it 'does not change current second player' do
          @request[:current_player] = @request[:players][1]
          EndTurn.new(@request).invoke
          expect(@request[:current_player]).to be(@request[:players][1])
        end
      end

      context 'when third turn' do
        before (:each) do
          @request[:turn] = 3
        end

        it 'makes second player current when first is current' do
          EndTurn.new(@request).invoke
          expect(@request[:current_player]).to be(@request[:players][1])
        end

        it 'makes first player current when second is current' do
          @request[:current_player] = @request[:players][1]
          EndTurn.new(@request).invoke
          expect(@request[:current_player]).to be(@request[:players][0])
        end
      end

      context 'when fourth turn' do
        before (:each) do
          @request[:turn] = 4
        end

        it 'makes second player current when first is current' do
          EndTurn.new(@request).invoke
          expect(@request[:current_player]).to be(@request[:players][1])
        end

        it 'makes first player current when second is current' do
          @request[:current_player] = @request[:players][1]
          EndTurn.new(@request).invoke
          expect(@request[:current_player]).to be(@request[:players][0])
        end
      end
    end

    context 'when 3 players' do
      before (:each) do
        players = valid_players
        players << Player.new('Spejson', :white)
        @request[:players] = players
      end

      context 'when first turn' do
        it 'makes third player current when second is current' do
          @request[:current_player] = @request[:players][1]
          EndTurn.new(@request).invoke
          expect(@request[:current_player]).to be(@request[:players][2])
        end

        it 'makes first player current when third is current' do
          @request[:current_player] = @request[:players][2]
          EndTurn.new(@request).invoke
          expect(@request[:current_player]).to be(@request[:players][0])
        end
      end

      context 'when second turn' do
        before (:each) do
          @request[:turn] = 2
        end

        it 'makes second player current when first is current' do
          @request[:current_player] = @request[:players][0]
          EndTurn.new(@request).invoke
          expect(@request[:current_player]).to be(@request[:players][1])
        end

        it 'makes first player current when third is current' do
          @request[:current_player] = @request[:players][2]
          EndTurn.new(@request).invoke
          expect(@request[:current_player]).to be(@request[:players][0])
        end
      end

      context 'when third turn' do
        before (:each) do
          @request[:turn] = 3
        end

        it 'does not change current first player' do
          @request[:current_player] = @request[:players][0]
          EndTurn.new(@request).invoke
          expect(@request[:current_player]).to be(@request[:players][0])
        end

        it 'does not change current second player' do
          @request[:current_player] = @request[:players][1]
          EndTurn.new(@request).invoke
          expect(@request[:current_player]).to be(@request[:players][1])
        end

        it 'does not change current third player' do
          @request[:current_player] = @request[:players][2]
          EndTurn.new(@request).invoke
          expect(@request[:current_player]).to be(@request[:players][2])
        end
      end

      context 'when fourth turn' do
        before (:each) do
          @request[:turn] = 4
        end

        it 'makes third player current when first is current' do
          @request[:current_player] = @request[:players][0]
          EndTurn.new(@request).invoke
          expect(@request[:current_player]).to be(@request[:players][2])
        end

        it 'makes first player current when second is current' do
          @request[:current_player] = @request[:players][1]
          EndTurn.new(@request).invoke
          expect(@request[:current_player]).to be(@request[:players][0])
        end

        it 'makes second player current when third is current' do
          @request[:current_player] = @request[:players][2]
          EndTurn.new(@request).invoke
          expect(@request[:current_player]).to be(@request[:players][1])
        end
      end

      context 'when 6th turn' do
        before (:each) do
          @request[:turn] = 6
        end

        it 'makes second player current when first is current' do
          @request[:current_player] = @request[:players][0]
          EndTurn.new(@request).invoke
          expect(@request[:current_player]).to be(@request[:players][1])
        end

        it 'makes third player current when second is current' do
          @request[:current_player] = @request[:players][1]
          EndTurn.new(@request).invoke
          expect(@request[:current_player]).to be(@request[:players][2])
        end

        it 'makes first player current when third is current' do
          @request[:current_player] = @request[:players][2]
          EndTurn.new(@request).invoke
          expect(@request[:current_player]).to be(@request[:players][0])
        end
      end
    end
  end
end