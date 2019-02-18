describe SerializeGame do
  let(:valid_game) { Catan.new }
  let(:valid_request) { { game: valid_game } }

  it 'raises error if request is nil' do
    request = nil
    expect { SerializeGame.new(request).invoke }.to raise_error(
      Controller::InvalidParameters,
      'Params is not a hash'
    )
  end

  it 'raises error if request is not a hash' do
    request = []
    expect { SerializeGame.new(request).invoke }.to raise_error(
      Controller::InvalidParameters,
      'Params is not a hash'
    )
  end

  it 'requires game' do
    request = valid_request
    request.delete(:game)
    expect { SerializeGame.new(request).invoke }.to raise_error(
      Controller::InvalidParameters,
      'Missing :game key in params'
    )
  end

  it 'raises error if game is nil' do
    request = valid_request
    request[:game] = nil
    expect { SerializeGame.new(request).invoke }.to raise_error(
      Controller::InvalidParameters,
      ':game value is not of type Catan'
    )
  end

  it 'raises error if game is not a Catan' do
    request = valid_request
    request[:game] = "I'm a game"
    expect { SerializeGame.new(request).invoke }.to raise_error(
      Controller::InvalidParameters,
      ':game value is not of type Catan'
    )
  end

  context 'when valid request' do
    it 'can be successfully invoked' do
      request = valid_request
      expect { SerializeGame.new(request).invoke }.not_to raise_error
    end
  end
end
