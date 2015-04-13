require 'spec_helper'

describe SetupGame do
  it 'raises error if layers count is a zero' do
    request = {:layers_count => 0}
    expect{ SetupGame.new.invoke(request) }.to raise_error(SetupGame::InvalidParameters)
  end

  it 'raises error if layers count is a negative number' do
    request = {:layers_count => -1}
    expect{ SetupGame.new.invoke(request) }.to raise_error(SetupGame::InvalidParameters)
  end

  it 'raises error if passed nil' do
    request = nil
    expect{ SetupGame.new.invoke(request) }.to raise_error(SetupGame::InvalidParameters)
  end

  it 'raises error if request is not a hash' do
    request = []
    expect{ SetupGame.new.invoke(request) }.to raise_error(SetupGame::InvalidParameters)
  end

  it 'raises error if layers_count not specified' do
    request = {}
    expect{ SetupGame.new.invoke(request) }.to raise_error(SetupGame::InvalidParameters)
  end

  describe 'when initialized' do
    before(:each) do
      @layers_count = 4
      @request = {:layers_count => @layers_count}
      @map, @users = SetupGame.new.invoke(@request)
    end

    it 'returns a pair' do
      expect(@map).to be_truthy
      expect(@users).to be_truthy
    end

    it 'returns map as first argument' do
      expect(@map).to be_instance_of Map
    end

    it 'returns map with as many layers as specified' do
      expect(@map.layers_count).to eq(@layers_count)
    end
  end
end