describe GainResourcesAroundSettlement do
  let(:valid_current_player) { Player.new(name: 'Bartek', color: :orange) }
  let(:valid_place) { 8 }
  let(:valid_map) { Map.new_random }
  let(:valid_request) do
    { map: valid_map,
      place: valid_place,
      current_player: valid_current_player }
  end

  it 'raises error if request is nil' do
    request = nil
    expect { GainResourcesAroundSettlement.new(request).invoke }.to raise_error(
      Controller::InvalidParameters,
      'Params is not a hash'
    )
  end

  it 'raises error if request is not a hash' do
    request = []
    expect { GainResourcesAroundSettlement.new(request).invoke }.to raise_error(
      Controller::InvalidParameters,
      'Params is not a hash'
    )
  end

  it 'requires current_player' do
    request = valid_request
    request.delete(:current_player)
    expect { GainResourcesAroundSettlement.new(request).invoke }.to raise_error(
      Controller::InvalidParameters,
      'Missing :current_player key in params'
    )
  end

  it 'raises error if current_player is nil' do
    request = valid_request
    request[:current_player] = nil
    expect { GainResourcesAroundSettlement.new(request).invoke }.to raise_error(
      Controller::InvalidParameters,
      ':current_player value is not of type Player'
    )
  end

  it 'raises error if current_player is not a player' do
    request = valid_request
    request[:current_player] = "Let me play, I'm a player"
    expect { GainResourcesAroundSettlement.new(request).invoke }.to raise_error(
      Controller::InvalidParameters,
      ':current_player value is not of type Player'
    )
  end

  it 'requires place' do
    request = valid_request
    request.delete(:place)
    expect { GainResourcesAroundSettlement.new(request).invoke }.to raise_error(
      Controller::InvalidParameters,
      'Missing :place key in params'
    )
  end

  it 'raises error if place is nil' do
    request = valid_request
    request[:place] = nil
    expect { GainResourcesAroundSettlement.new(request).invoke }.to raise_error(
      Controller::InvalidParameters,
      ':place value is not of type Integer'
    )
  end

  it 'raises error if place is NaN' do
    request = valid_request
    request[:place] = '1'
    expect { GainResourcesAroundSettlement.new(request).invoke }.to raise_error(
      Controller::InvalidParameters,
      ':place value is not of type Integer'
    )
  end

  it 'requires map' do
    request = valid_request
    request.delete(:map)
    expect { GainResourcesAroundSettlement.new(request).invoke }.to raise_error(
      Controller::InvalidParameters,
      'Missing :map key in params'
    )
  end

  it 'raises error if map is nil' do
    request = valid_request
    request[:map] = nil
    expect { GainResourcesAroundSettlement.new(request).invoke }.to raise_error(
      Controller::InvalidParameters,
      ':map value is not of type Map'
    )
  end

  it 'raises error if map is not a map' do
    request = valid_request
    request[:map] = 'There ore and there lumber'
    expect { GainResourcesAroundSettlement.new(request).invoke }.to raise_error(
      Controller::InvalidParameters,
      ':map value is not of type Map'
    )
  end

  context 'when valid request' do
    it 'can be successfully invoked' do
      request = valid_request
      expect { GainResourcesAroundSettlement.new(request).invoke }.not_to raise_error
    end

    it 'gives player one of every resources around' do
      map = Map.new_random
      map.fields[1] = Field.new(2, :ore, 1)
      map.fields[7] = Field.new(8, :lumber, 1)
      map.fields[8] = Field.new(9, :brick, 1)
      request = valid_request
      request[:map] = map
      GainResourcesAroundSettlement.new(request).invoke
      expect_resources(request[:current_player], 1, 1, 1, 0, 0)
    end

    it 'gives player two resources if fields repeats' do
      map = Map.new_random
      map.fields[1] = Field.new(2, :ore, 1)
      map.fields[7] = Field.new(8, :brick, 1)
      map.fields[8] = Field.new(9, :brick, 1)
      request = valid_request
      request[:map] = map
      GainResourcesAroundSettlement.new(request).invoke
      expect_resources(request[:current_player], 0, 1, 2, 0, 0)
    end

    it 'gives player three resources if fields repeats' do
      map = Map.new_random
      map.fields[1] = Field.new(2, :brick, 1)
      map.fields[7] = Field.new(8, :brick, 1)
      map.fields[8] = Field.new(9, :brick, 1)
      request = valid_request
      request[:map] = map
      GainResourcesAroundSettlement.new(request).invoke
      expect_resources(request[:current_player], 0, 0, 3, 0, 0)
    end

    it 'ignores desert' do
      map = Map.new_random
      map.fields[1] = Field.new(2, :desert, 1)
      map.fields[7] = Field.new(8, :grain, 1)
      map.fields[8] = Field.new(9, :brick, 1)
      request = valid_request
      request[:map] = map
      GainResourcesAroundSettlement.new(request).invoke
      expect_resources(request[:current_player], 0, 0, 1, 1, 0)
    end

    it 'gives only two resources if place has two fields' do
      map = Map.new_random
      map.fields[7] = Field.new(8, :grain, 1)
      map.fields[8] = Field.new(9, :wool, 1)
      request = valid_request
      request[:map] = map
      request[:place] = 27
      GainResourcesAroundSettlement.new(request).invoke
      expect_resources(request[:current_player], 0, 0, 0, 1, 1)
    end

    it 'gives only one resource if place has two same fields' do
      map = Map.new_random
      map.fields[7] = Field.new(8, :wool, 1)
      map.fields[8] = Field.new(9, :wool, 1)
      request = valid_request
      request[:map] = map
      request[:place] = 27
      GainResourcesAroundSettlement.new(request).invoke
      expect_resources(request[:current_player], 0, 0, 0, 0, 2)
    end

    it 'gives only one resource if place has one field' do
      map = Map.new_random
      map.fields[7] = Field.new(8, :lumber, 1)
      request = valid_request
      request[:map] = map
      request[:place] = 26
      GainResourcesAroundSettlement.new(request).invoke
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
