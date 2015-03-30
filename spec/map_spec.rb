require 'spec_helper'

describe Map do
  it 'can take other numbers of layers' do
    expect(Map.new(5).layers).to eq(5)
    expect(Map.new(8).layers).to eq(8)
  end

  it 'cannot take non-positive numbers of layers' do
    expect{ Map.new(0).layers }.to raise_error
    expect{ Map.new(-1).layers }.to raise_error
  end

  it 'can have other numbers of places' do
    expect(Map.new(5).places.count).to eq(5 * 5 * 6)
    expect(Map.new(2).places.count).to eq(2 * 2 * 6)
  end

  describe 'when created properly' do
    before (:each) do
      @map = Map.new(3)
    end

    it 'has places included' do
      expect(@map.places).not_to be_empty
      @map.places.each do |place|
        expect(place).to be_instance_of(Place)
      end
    end

    it 'has proper number of places' do
      expect(@map.places.count).to eq(@map.layers * @map.layers * 6)
    end

    it 'has every place with its number' do
      @map.places.each.with_index(1) do |place, index|
        expect(place.index).to eq(index)
      end
    end

    it 'can get every place by its index' do
      @map.places.each.with_index(1) do |place, index|
        expect(@map.get_place(index)).to be(place)
      end
    end

    it 'can access to first place' do
      expect(@map.get_place(:first)).to be(@map.places.first)
    end

    it 'can access to last place' do
      expect(@map.get_place(:last)).to be(@map.places.last)
    end

    it 'fails when try to get too low-numbered place' do
      expect{ @map.get_place(0) }.to raise_error(Map::BeyondRangeError)
    end

    it 'fails when try to get too high-numbered place' do
      expect{ @map.get_place(55) }.to raise_error(Map::BeyondRangeError)
    end

    it 'has first place in layer 1' do
      expect(@map.get_place(:first).layer).to eq(1)
    end

    it 'has second place in layer 1' do
      expect(@map.get_place(2).layer).to eq(1)
    end

    it 'has 6th place in layer 2' do
      expect(@map.get_place(6).layer).to eq(1)
    end

    it 'has 7th place in layer 2' do
      expect(@map.get_place(7).layer).to eq(2)
    end

    it 'has 24th place in layer 2' do
      expect(@map.get_place(24).layer).to eq(2)
    end

    it 'has 25th place in layer 3' do
      expect(@map.get_place(25).layer).to eq(3)
    end

    it 'has 54nd (last) place in layer 3' do
      expect(@map.get_place(:last).layer).to eq(3)
    end

    it 'has first place in side 1' do
      expect(@map.get_place(:first).side).to eq(1)
    end

    it 'has second place in side 2' do
      expect(@map.get_place(2).side).to eq(2)
    end

    it 'has 6th place in side 6' do
      expect(@map.get_place(6).side).to eq(6)
    end

    it 'has 7th place in side 1' do
      expect(@map.get_place(7).side).to eq(1)
    end

    it 'has 8th place in side 1' do
      expect(@map.get_place(8).side).to eq(1)
    end

    it 'has 9th place in side 1' do
      expect(@map.get_place(9).side).to eq(1)
    end

    it 'has 10th place in side 2' do
      expect(@map.get_place(10).side).to eq(2)
    end

    it 'has 12th place in side 2' do
      expect(@map.get_place(12).side).to eq(2)
    end

    it 'has 13th place in side 3' do
      expect(@map.get_place(13).side).to eq(3)
    end

    it 'has 24th place in side 6' do
      expect(@map.get_place(24).side).to eq(6)
    end

    it 'has 25th place in side 1' do
      expect(@map.get_place(25).side).to eq(1)
    end

    it 'has 29th place in side 1' do
      expect(@map.get_place(29).side).to eq(1)
    end

    it 'has 30th place in side 2' do
      expect(@map.get_place(30).side).to eq(2)
    end

    it 'has 34th place in side 2' do
      expect(@map.get_place(34).side).to eq(2)
    end

    it 'has 35th place in side 3' do
      expect(@map.get_place(35).side).to eq(3)
    end

    it 'has first place in spot 1' do
      expect(@map.get_place(:first).spot).to eq(1)
    end

    it 'has second place in spot 1' do
      expect(@map.get_place(2).spot).to eq(1)
    end

    it 'has 7th place in spot 1' do
      expect(@map.get_place(7).spot).to eq(1)
    end

    it 'has 8th place in spot 2' do
      expect(@map.get_place(8).spot).to eq(2)
    end

    it 'has 9th place in spot 3' do
      expect(@map.get_place(9).spot).to eq(3)
    end

    it 'has 10th place in spot 1' do
      expect(@map.get_place(10).spot).to eq(1)
    end

    it 'has 13th place in spot 1' do
      expect(@map.get_place(13).spot).to eq(1)
    end

    it 'has 24th place in spot 6' do
      expect(@map.get_place(24).spot).to eq(3)
    end

    it 'has 25th place in spot 1' do
      expect(@map.get_place(25).spot).to eq(1)
    end

    it 'has 28th place in spot 4' do
      expect(@map.get_place(28).spot).to eq(4)
    end

    it 'has 29th place in spot 5' do
      expect(@map.get_place(29).spot).to eq(5)
    end

    it 'has 30th place in spot 1' do
      expect(@map.get_place(30).spot).to eq(1)
    end

    it 'has 34th place in spot 5' do
      expect(@map.get_place(34).spot).to eq(5)
    end

    it 'has 35th place in spot 1' do
      expect(@map.get_place(35).spot).to eq(1)
    end

    it 'has last place in spot 5' do
      expect(@map.get_place(:last).spot).to eq(5)
    end

  end

end