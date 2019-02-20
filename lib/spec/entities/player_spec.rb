describe Player do
  let(:player) { Player.new('Player', :blue) }

  it 'has resources' do
    expect { player.resources }.not_to raise_error
  end

  RESOURCE_NAMES.each do |resource_name|
    it "has #{resource_name} resource" do
      expect(player.resources[resource_name]).not_to be_nil
    end
  end

  describe 'serialization' do
    context 'no resources' do
      let(:json) { '{"color":"blue","name":"Player","resources":{"ore":0,"lumber":0,"wool":0,"grain":0,"brick":0}}' }

      it 'is serializable' do
        expect(player.to_json).to eq(json)
      end

      it 'is deserializable' do
        expect(Player.from_json(json)).to eq(player)
      end
    end

    context 'some resources' do
      let(:resources) { { ore: 1, lumber: 2, wool: 3, grain: 4, brick: 5 } }
      let(:player) { Player.new('Player', :blue, resources) }
      let(:json) { '{"color":"blue","name":"Player","resources":{"ore":1,"lumber":2,"wool":3,"grain":4,"brick":5}}' }

      it 'is serializable' do
        expect(player.to_json).to eq(json)
      end

      it 'is deserializable' do
        expect(Player.from_json(json)).to eq(player)
      end
    end
  end
end
