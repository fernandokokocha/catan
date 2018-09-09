describe GainResourcesAroundCity do
  let(:valid_current_player) { Player.new('Bartek', :orange) }
  let(:valid_place) { 8 }
  let(:valid_map) { Map.new }
  let(:valid_request) { {:map => valid_map,
                         :place => valid_place,
                         :current_player => valid_current_player} }

  it 'raises error if request is nil' do
    request = nil
    expect{ GainResourcesAroundCity.new(request).invoke }.to raise_error(Controller::InvalidParameters)
  end

  it 'raises error if request is not a hash' do
    request = []
    expect{ GainResourcesAroundCity.new(request).invoke }.to raise_error(Controller::InvalidParameters)
  end

  it 'requires current_player' do
    request = valid_request
    request.delete(:current_player)
    expect{ GainResourcesAroundCity.new(request).invoke }.to raise_error(Controller::InvalidParameters)
  end

  it 'raises error if current_player is nil' do
    request = valid_request
    request[:current_player] = nil
    expect{ GainResourcesAroundCity.new(request).invoke }.to raise_error(Controller::InvalidParameters)
  end

  it 'raises error if current_player is not a player' do
    request = valid_request
    request[:current_player] = "Let me play, I'm a player"
    expect{ GainResourcesAroundCity.new(request).invoke }.to raise_error(Controller::InvalidParameters)
  end

  it 'requires place' do
    request = valid_request
    request.delete(:place)
    expect{ GainResourcesAroundCity.new(request).invoke }.to raise_error(Controller::InvalidParameters)
  end

  it 'raises error if place is nil' do
    request = valid_request
    request[:place] = nil
    expect{ GainResourcesAroundCity.new(request).invoke }.to raise_error(Controller::InvalidParameters)
  end

  it 'raises error if place is NaN' do
    request = valid_request
    request[:place] = '1'
    expect{ GainResourcesAroundCity.new(request).invoke }.to raise_error(Controller::InvalidParameters)
  end

  it 'requires map' do
    request = valid_request
    request.delete(:map)
    expect{ GainResourcesAroundCity.new(request).invoke }.to raise_error(Controller::InvalidParameters)
  end

  it 'raises error if map is nil' do
    request = valid_request
    request[:map] = nil
    expect{ GainResourcesAroundCity.new(request).invoke }.to raise_error(Controller::InvalidParameters)
  end

  it 'raises error if map is not a map' do
    request = valid_request
    request[:map] = 'There ore and there lumber'
    expect{ GainResourcesAroundCity.new(request).invoke }.to raise_error(Controller::InvalidParameters)
  end

  context 'when valid request' do
    it 'can be successfully invoked' do
      request = valid_request
      expect{ GainResourcesAroundCity.new(request).invoke }.not_to raise_error
    end

    it 'gives player one of every resources around' do
      map = Map.new
      map.fields[1] = Field.new(2, :ore, 1)
      map.fields[7] = Field.new(8, :lumber, 1)
      map.fields[8] = Field.new(9, :brick, 1)
      request = valid_request
      request[:map] = map
      GainResourcesAroundCity.new(request).invoke
      expect_resources(request[:current_player], 1, 1, 1, 0, 0)
    end

    it 'gives player two resources if fields repeats' do
      map = Map.new
      map.fields[1] = Field.new(2, :ore, 1)
      map.fields[7] = Field.new(8, :brick, 1)
      map.fields[8] = Field.new(9, :brick, 1)
      request = valid_request
      request[:map] = map
      GainResourcesAroundCity.new(request).invoke
      expect_resources(request[:current_player], 0, 1, 2, 0, 0)
    end

    it 'gives player three resources if fields repeats' do
      map = Map.new
      map.fields[1] = Field.new(2, :brick, 1)
      map.fields[7] = Field.new(8, :brick, 1)
      map.fields[8] = Field.new(9, :brick, 1)
      request = valid_request
      request[:map] = map
      GainResourcesAroundCity.new(request).invoke
      expect_resources(request[:current_player], 0, 0, 3, 0, 0)
    end

    it 'ignores desert' do
      map = Map.new
      map.fields[1] = Field.new(2, :desert, 1)
      map.fields[7] = Field.new(8, :grain, 1)
      map.fields[8] = Field.new(9, :brick, 1)
      request = valid_request
      request[:map] = map
      GainResourcesAroundCity.new(request).invoke
      expect_resources(request[:current_player], 0, 0, 1, 1, 0)
    end

    it 'gives only two resources if place has two fields' do
      map = Map.new
      map.fields[7] = Field.new(8, :grain, 1)
      map.fields[8] = Field.new(9, :wool, 1)
      request = valid_request
      request[:map] = map
      request[:place] = 27
      GainResourcesAroundCity.new(request).invoke
      expect_resources(request[:current_player], 0, 0, 0, 1, 1)
    end

    it 'gives only one resource if place has two same fields' do
      map = Map.new
      map.fields[7] = Field.new(8, :wool, 1)
      map.fields[8] = Field.new(9, :wool, 1)
      request = valid_request
      request[:map] = map
      request[:place] = 27
      GainResourcesAroundCity.new(request).invoke
      expect_resources(request[:current_player], 0, 0, 0, 0, 2)
    end

    it 'gives only one resource if place has one field' do
      map = Map.new
      map.fields[7] = Field.new(8, :lumber, 1)
      request = valid_request
      request[:map] = map
      request[:place] = 26
      GainResourcesAroundCity.new(request).invoke
      expect_resources(request[:current_player], 1, 0, 0, 0, 0)
    end
  end

  def expect_resources(player, lumber, ore, brick, grain, wool)
    expect(player.resources[:lumber]).to eq(lumber)
    expect(player.resources[:ore]).to eq(ore)
    expect(player.resources[:brick]).to eq(brick)
    expect(player.resources[:grain]).to eq(grain)
    expect(player.resources[:wool]).to eq(wool)
  end
end
