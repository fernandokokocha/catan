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

    it 'has places' do
      expect(@map.places).not_to be_empty
      @map.places.each do |place|
        expect(place).to be_instance_of(Place)
      end
    end

    it 'has proper number of places' do
      expect(@map.places.count).to eq(@map.layers * @map.layers * 6)
    end

    it 'has every place numbered' do
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

    it 'return nil when try to get nil-place' do
      expect(@map.get_place(nil)).to be_nil
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

    it 'knows that places 2, 6 and 24 are neighbours of place 1' do
      expect(@map.get_neighbours(1)).to contain_exactly(@map.get_place(2),
                                                        @map.get_place(6),
                                                        @map.get_place(24))
    end

    it 'knows that places 1, 3 and 9 are neighbours of place 2' do
      expect(@map.get_neighbours(2)).to contain_exactly(@map.get_place(1),
                                                        @map.get_place(3),
                                                        @map.get_place(9))
    end

    it 'knows that places 2, 4 and 12 are neighbours of place 3' do
      expect(@map.get_neighbours(3)).to contain_exactly(@map.get_place(2),
                                                        @map.get_place(4),
                                                        @map.get_place(12))
    end

    it 'knows that places 5, 1 and 21 are neighbours of place 6' do
      expect(@map.get_neighbours(6)).to contain_exactly(@map.get_place(5),
                                                        @map.get_place(1),
                                                        @map.get_place(21))
    end

    it 'knows that places 8, 24 and 54 are neighbours of place 7' do
      expect(@map.get_neighbours(7)).to contain_exactly(@map.get_place(8),
                                                        @map.get_place(24),
                                                        @map.get_place(54))
    end

    it 'knows that places 7, 9 and 27 are neighbours of place 8' do
      expect(@map.get_neighbours(8)).to contain_exactly(@map.get_place(7),
                                                        @map.get_place(9),
                                                        @map.get_place(27))
    end

    it 'knows that places 2, 8 and 10 are neighbours of place 9' do
      expect(@map.get_neighbours(9)).to contain_exactly(@map.get_place(2),
                                                        @map.get_place(8),
                                                        @map.get_place(10))
    end

    it 'knows that places 9, 11 and 29 are neighbours of place 10' do
      expect(@map.get_neighbours(10)).to contain_exactly(@map.get_place(9),
                                                        @map.get_place(11),
                                                        @map.get_place(29))
    end

    it 'knows that places 10, 12 and 32 are neighbours of place 11' do
      expect(@map.get_neighbours(11)).to contain_exactly(@map.get_place(10),
                                                         @map.get_place(12),
                                                         @map.get_place(32))
    end

    it 'knows that places 3, 11 and 13 are neighbours of place 12' do
      expect(@map.get_neighbours(12)).to contain_exactly(@map.get_place(3),
                                                         @map.get_place(11),
                                                         @map.get_place(13))
    end

    it 'knows that places 22, 24 and 52 are neighbours of place 23' do
      expect(@map.get_neighbours(23)).to contain_exactly(@map.get_place(22),
                                                         @map.get_place(24),
                                                         @map.get_place(52))
    end

    it 'knows that places 1, 7 and 23 are neighbours of place 24' do
      expect(@map.get_neighbours(24)).to contain_exactly(@map.get_place(1),
                                                         @map.get_place(7),
                                                         @map.get_place(23))
    end

    it 'knows that places 26 and 54 are neighbours of place 25' do
      expect(@map.get_neighbours(25)).to contain_exactly(@map.get_place(26),
                                                         @map.get_place(54))
    end

    it 'knows that places 25 and 27 are neighbours of place 26' do
      expect(@map.get_neighbours(26)).to contain_exactly(@map.get_place(25),
                                                         @map.get_place(27))
    end

    it 'knows that places 8, 26 and 28 are neighbours of place 27' do
      expect(@map.get_neighbours(27)).to contain_exactly(@map.get_place(8),
                                                         @map.get_place(26),
                                                         @map.get_place(28))
    end

    it 'knows that places 27 and 29 are neighbours of place 28' do
      expect(@map.get_neighbours(28)).to contain_exactly(@map.get_place(27),
                                                         @map.get_place(29))
    end

    it 'knows that places 10, 28 and 30 are neighbours of place 29' do
      expect(@map.get_neighbours(29)).to contain_exactly(@map.get_place(10),
                                                         @map.get_place(28),
                                                         @map.get_place(30))
    end

    it 'knows that places 29 and 31 are neighbours of place 30' do
      expect(@map.get_neighbours(30)).to contain_exactly(@map.get_place(29),
                                                         @map.get_place(31))
    end

    it 'knows that places 11, 31 and 33 are neighbours of place 32' do
      expect(@map.get_neighbours(32)).to contain_exactly(@map.get_place(11),
                                                         @map.get_place(31),
                                                         @map.get_place(33))
    end

    it 'knows that places 13, 33 and 35 are neighbours of place 34' do
      expect(@map.get_neighbours(34)).to contain_exactly(@map.get_place(13),
                                                         @map.get_place(33),
                                                         @map.get_place(35))
    end

    it 'knows that places 23, 51 and 53 are neighbours of place 52' do
      expect(@map.get_neighbours(52)).to contain_exactly(@map.get_place(23),
                                                         @map.get_place(51),
                                                         @map.get_place(53))
    end

    it 'knows that places 52 and 54 are neighbours of place 53' do
      expect(@map.get_neighbours(53)).to contain_exactly(@map.get_place(52),
                                                         @map.get_place(54))
    end

    it 'knows that places 7, 25 and 53 are neighbours of place 54' do
      expect(@map.get_neighbours(54)).to contain_exactly(@map.get_place(7),
                                                         @map.get_place(25),
                                                         @map.get_place(53))
    end

    it 'fails when try to get neighbours of too low-numbered place' do
      expect{ @map.get_neighbours(0) }.to raise_error(Map::BeyondRangeError)
    end

    it 'fails when try to get neighbours of too high-numbered place' do
      expect{ @map.get_neighbours(55) }.to raise_error(Map::BeyondRangeError)
    end

    it 'has real fields' do
      expect(@map.fields).not_to be_empty
      @map.fields.each do |field|
        expect(field).to be_instance_of(Field)
      end
    end

    it 'has proper number of fields' do
      expect(@map.fields.count).to eq(1 + 6 + 12)
    end

    it 'has every field numbered' do
      @map.fields.each.with_index(1) do |field, index|
        expect(field.index).to eq(index)
      end
    end

  end

end