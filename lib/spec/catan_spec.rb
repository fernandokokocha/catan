describe Catan do
  before (:each) do
    @app = Catan.new
  end

  it 'has map' do
    expect(@app).to respond_to(:map)
  end

  it 'has players' do
    expect(@app).to respond_to(:players)
  end

  it 'has current_player' do
    expect(@app).to respond_to(:current_player)
  end

  it 'has turn' do
    expect(@app).to respond_to(:turn)
  end
end
