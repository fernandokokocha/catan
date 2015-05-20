require 'spec_helper'

describe SettleWithRoad do
  let(:valid_place) { 1 }
  let(:valid_neighbour) { 2 }
  let(:valid_map) { Map.new }
  let(:valid_current_player) { Player.new('Bartek', :orange) }
  let(:valid_request) { {:place => valid_place,
                         :neighbour => valid_neighbour,
                         :map => valid_map,
                         :current_player => valid_current_player} }

  it 'raises error if request is nil' do
    request = nil
    expect{ SettleWithRoad.new(request).invoke }.to raise_error(Controller::InvalidParameters)
  end

  it 'raises error if request is not a hash' do
    request = []
    expect{ SettleWithRoad.new(request).invoke }.to raise_error(Controller::InvalidParameters)
  end

  it 'requires map' do
    request = valid_request
    request.delete(:map)
    expect{ SettleWithRoad.new(request).invoke }.to raise_error(Controller::InvalidParameters)
  end

  it 'raises error if map is nil' do
    request = valid_request
    request[:map] = nil
    expect{ SettleWithRoad.new(request).invoke }.to raise_error(Controller::InvalidParameters)
  end

  it 'raises error unless map is my map' do
    request = valid_request
    request[:map] = "hey trust me, I'm a map"
    expect{ SettleWithRoad.new(request).invoke }.to raise_error(Controller::InvalidParameters)
  end

  it 'requires place' do
    request = valid_request
    request.delete(:place)
    expect{ SettleWithRoad.new(request).invoke }.to raise_error(Controller::InvalidParameters)
  end

  it 'raises error if place is nil' do
    request = valid_request
    request[:map] = nil
    expect{ SettleWithRoad.new(request).invoke }.to raise_error(Controller::InvalidParameters)
  end

  it 'raises error if place is NaN' do
    request = valid_request
    request[:map] = '5'
    expect{ SettleWithRoad.new(request).invoke }.to raise_error(Controller::InvalidParameters)
  end

  it 'raises error if place is not in map' do
    request = valid_request
    request[:map] = 102
    expect{ SettleWithRoad.new(request).invoke }.to raise_error(Controller::InvalidParameters)
  end

  it 'requires neighbour' do
    request = valid_request
    request.delete(:neighbour)
    expect{ SettleWithRoad.new(request).invoke }.to raise_error(Controller::InvalidParameters)
  end

  it 'raises error if neighbour is nil' do
    request = valid_request
    request[:neighbour] = nil
    expect{ SettleWithRoad.new(request).invoke }.to raise_error(Controller::InvalidParameters)
  end

  it 'raises error if neighbour is NaN' do
    request = valid_request
    request[:neighbour] = nil
    expect{ SettleWithRoad.new(request).invoke }.to raise_error(Controller::InvalidParameters)
  end

  it 'raises error if neighbour is not in map' do
    request = valid_request
    request[:neighbour] = 102
    expect{ SettleWithRoad.new(request).invoke }.to raise_error(Controller::InvalidParameters)
  end

  it 'raises error if neighbour is not a neighbour' do
    request = valid_request
    request[:neighbour] = 50
    expect{ SettleWithRoad.new(request).invoke }.to raise_error(Controller::InvalidParameters)
  end

  it 'fails when place is already taken' do
    player = Player.new('Player', :orange)
    map = valid_map
    map.get_place(valid_place).settle(player)
    request = valid_request
    request[:map] = map
    expect{ SettleWithRoad.new(request).invoke }.to raise_error(Controller::InvalidParameters)
  end

  it 'fails when neighbour is already taken' do
    player = Player.new('Player', :orange)
    map = valid_map
    map.get_place(valid_neighbour).settle(player)
    request = valid_request
    request[:map] = map
    expect{ SettleWithRoad.new(request).invoke }.to raise_error(Controller::InvalidParameters)
  end

  it 'requires current_player' do
    request = valid_request
    request.delete(:current_player)
    expect{ SettleWithRoad.new(request).invoke }.to raise_error(Controller::InvalidParameters)
  end

  it 'fails if current_player is nil' do
    request = valid_request
    request[:current_player] = nil
    expect{ SettleWithRoad.new(request).invoke }.to raise_error(Controller::InvalidParameters)
  end

  it 'fails if current_player is not my player' do
    request = valid_request
    request[:current_player] = 'A player'
    expect{ SettleWithRoad.new(request).invoke }.to raise_error(Controller::InvalidParameters)
  end

  context 'when valid request' do
    it 'settles place' do
      request = valid_request
      SettleWithRoad.new(request).invoke
      expect(request[:map].get_place(request[:place]).settled_by).to eq(request[:current_player])
    end

    it 'builds road from place to neighbour' do
      request = valid_request
      SettleWithRoad.new(request).invoke
      expect(request[:map].get_place(request[:place]).roads).to contain_exactly([request[:neighbour],
                                                                                 request[:current_player]])
    end

    it 'builds road from neighbour to place' do
      request = valid_request
      SettleWithRoad.new(request).invoke
      expect(request[:map].get_place(request[:neighbour]).roads).to contain_exactly([request[:place],
                                                                                     request[:current_player]])
    end
  end
end