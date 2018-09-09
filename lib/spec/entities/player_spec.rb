describe Player do
  it 'has resources' do
    expect{ Player.new('Player', :blue).resources }.not_to raise_error
  end

  it 'has ore resources' do
    expect{ Player.new('Player', :blue).resources[:ore] }.not_to raise_error
  end

  it 'has lumber resource' do
    expect{ Player.new('Player', :blue).resources[:lumber] }.not_to raise_error
  end

  it 'has wool resource' do
    expect{ Player.new('Player', :blue).resources[:wool] }.not_to raise_error
  end

  it 'has brick resource' do
    expect{ Player.new('Player', :blue).resources[:brick] }.not_to raise_error
  end

  it 'has grain resource' do
    expect{ Player.new('Player', :blue).resources[:grain] }.not_to raise_error
  end
end
