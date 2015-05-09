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
    it 'invokes' do
      request = valid_request
      expect{ EndTurn.new(request).invoke }.not_to raise_error
    end
  end
end