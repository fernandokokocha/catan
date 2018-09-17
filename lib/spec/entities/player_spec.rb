describe Player do
  before do
    @player = Player.new('Player', :blue)
  end

  it 'has resources' do
    expect{ @player.resources }.not_to raise_error
  end

  RESOURCE_NAMES.each do |resource_name|
    it "has #{resource_name} resource" do
      expect(@player.resources[resource_name]).not_to be_nil
    end
  end
end
