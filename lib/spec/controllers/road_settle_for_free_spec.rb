require 'spec_helper'

describe RoadSettleForFree do
  let(:valid_place) { 1 }
  let(:valid_neighbour) { 2 }
  let(:valid_map) { Map.new(3) }

  it 'raises error if request is not a hash' do
    request = nil
    expect{ RoadSettleForFree.new(request).invoke }.to raise_error(Controller::InvalidParameters)
  end

  it 'requires map' do
    request = {:place => valid_place,
               :neighbour => valid_neighbour}
    expect{ RoadSettleForFree.new(request).invoke }.to raise_error(Controller::InvalidParameters)
  end

  it 'raises error unless map is my map' do
    request = {:map => "hey trust me, I'm a map",
               :place => valid_place,
               :neighbour => valid_neighbour}
    expect{ RoadSettleForFree.new(request).invoke }.to raise_error(Controller::InvalidParameters)
  end

  it 'requires place' do
    request = {:map => valid_map,
               :neighbour => valid_neighbour}
    expect{ RoadSettleForFree.new(request).invoke }.to raise_error(Controller::InvalidParameters)
  end

  it 'raises error if place is not a number' do
    request = {:map => valid_map,
               :place => nil,
               :neighbour => valid_neighbour}
    expect{ RoadSettleForFree.new(request).invoke }.to raise_error(Controller::InvalidParameters)
  end

  it 'raises error if place is not in map' do
    request = {:map => valid_map,
               :place => 102,
               :neighbour => valid_neighbour}
    expect{ RoadSettleForFree.new(request).invoke }.to raise_error(Controller::InvalidParameters)
  end

  it 'requires neighbour' do
    request = {:map => valid_map,
               :place => valid_place}
    expect{ RoadSettleForFree.new(request).invoke }.to raise_error(Controller::InvalidParameters)
  end

  it 'raises error if neighbour is not a neighbour' do
    request = {:map => valid_map,
               :place => valid_place,
               :neighbour => 102}
    expect{ RoadSettleForFree.new(request).invoke }.to raise_error(Controller::InvalidParameters)
  end

  describe 'when valid request' do
    it 'successfully invokes' do
      request = {:map => valid_map,
                 :place => valid_place,
                 :neighbour => valid_neighbour}
      expect{ RoadSettleForFree.new(request).invoke }.not_to raise_error
    end
  end
end