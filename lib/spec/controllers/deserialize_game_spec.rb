describe DeserializeGame do
  let(:valid_dump) { 'String' }
  let(:valid_request) { { dump: valid_dump } }

  it 'raises error if request is nil' do
    request = nil
    expect { DeserializeGame.new(request).invoke }.to raise_error(
      Controller::InvalidParameters,
      'Params is not a hash'
    )
  end

  it 'raises error if request is not a hash' do
    request = []
    expect { DeserializeGame.new(request).invoke }.to raise_error(
      Controller::InvalidParameters,
      'Params is not a hash'
    )
  end

  it 'requires dump' do
    request = valid_request
    request.delete(:dump)
    expect { DeserializeGame.new(request).invoke }.to raise_error(
      Controller::InvalidParameters,
      'Missing :dump key in params'
    )
  end

  it 'raises error if dump is nil' do
    request = valid_request
    request[:dump] = nil
    expect { DeserializeGame.new(request).invoke }.to raise_error(
      Controller::InvalidParameters,
      ':dump value is not of type String'
    )
  end

  it 'raises error if game is not a String' do
    request = valid_request
    request[:dump] = 100
    expect { DeserializeGame.new(request).invoke }.to raise_error(
      Controller::InvalidParameters,
      ':dump value is not of type String'
    )
  end
end
