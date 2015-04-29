require 'spec_helper'

describe Map do
  let(:valid_resources) { [:brick, :lumber, :wool, :grain, :ore] }

  it 'cannot take non-positive numbers of layers' do
    expect{ Map.new(0) }.to raise_error(Map::BeyondRangeError)
    expect{ Map.new(-1) }.to raise_error(Map::BeyondRangeError)
  end

  it 'can take other numbers of layers' do
    expect{ Map.new(5) }.not_to raise_error
    expect{ Map.new(8) }.not_to raise_error
  end

  it 'can have other numbers of places' do
    expect(Map.new(5).places_count).to eq(5 * 5 * 6)
    expect(Map.new(2).places_count).to eq(2 * 2 * 6)
  end

  describe 'when created with 3 layers' do
    before (:each) do
      @layers = 3
      @map = Map.new(@layers)
    end

    it 'remembers number of layers' do
      expect(@map.layers_count).to eq(@layers)
    end

    it 'has proper number of places' do
      expect(@map.places_count).to eq(@layers * @layers * 6)
    end

    it 'can get every place by its index' do
      (1..@map.places_count).each do |index|
        expect(@map.get_place(index)).to be_instance_of(Place)
      end
    end

    it 'has every place numbered' do
      (1..@map.places_count).each do |index|
        expect(@map.get_place(index).index).to eq(index)
      end
    end

    it 'can access to first place' do
      expect(@map.get_place(:first).index).to eq(1)
    end

    it 'can access to last place' do
      expect(@map.get_place(:last).index).to eq(@map.places_count)
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















    it 'has proper number of fields' do
      expect(@map.fields_count).to eq(1 + 6 + 12)
    end

    it 'can get every field by its index' do
      (1..@map.fields_count).each do |index|
        expect(@map.get_field(index)).to be_instance_of(Field)
      end
    end

    it 'has every field numbered' do
      (1..@map.fields_count).each do |index|
        expect(@map.get_field(index).index).to eq(index)
      end
    end

    it 'can access to first field' do
      expect(@map.get_field(:first).index).to eq(1)
    end

    it 'can access to last field' do
      expect(@map.get_field(:last).index).to eq(@map.fields_count)
    end

    it 'return nil when try to get nil-field' do
      expect(@map.get_field(nil)).to be_nil
    end

    it 'fails when try to get too low-numbered field' do
      expect{ @map.get_field(0) }.to raise_error(Map::BeyondRangeError)
    end

    it 'fails when try to get too high-numbered field' do
      expect{ @map.get_field(20) }.to raise_error(Map::BeyondRangeError)
    end

    it 'returns nil when try to get nil field' do
      expect(@map.get_field(nil)).to be_nil
    end

    it 'knows that fields 1, 2 and 7 are nearby place 1' do
      expect(@map.get_fields_of_place(1)).to contain_exactly(@map.get_field(1),
                                                             @map.get_field(7),
                                                             @map.get_field(2))
    end

    it 'knows that fields 1, 2 and 7 are nearby place 2' do
      expect(@map.get_fields_of_place(2)).to contain_exactly(@map.get_field(1),
                                                             @map.get_field(2),
                                                             @map.get_field(3))
    end

    it 'knows that fields 1, 3 and 4 are nearby place 3' do
      expect(@map.get_fields_of_place(3)).to contain_exactly(@map.get_field(1),
                                                             @map.get_field(3),
                                                             @map.get_field(4))
    end

    it 'knows that fields 1, 6 and 7 are nearby place 6' do
      expect(@map.get_fields_of_place(6)).to contain_exactly(@map.get_field(1),
                                                             @map.get_field(6),
                                                             @map.get_field(7))
    end

    it 'knows that fields 2, 8 and 19 are nearby place 7' do
      expect(@map.get_fields_of_place(7)).to contain_exactly(@map.get_field(2),
                                                             @map.get_field(19),
                                                             @map.get_field(8))
    end

    it 'knows that fields 2, 8 and 9 are nearby place 8' do
      expect(@map.get_fields_of_place(8)).to contain_exactly(@map.get_field(2),
                                                             @map.get_field(8),
                                                             @map.get_field(9))
    end

    it 'knows that fields 2, 3 and 9 are nearby place 9' do
      expect(@map.get_fields_of_place(9)).to contain_exactly(@map.get_field(2),
                                                             @map.get_field(3),
                                                             @map.get_field(9))
    end

    it 'knows that fields 2, 3 and 9 are nearby place 10' do
      expect(@map.get_fields_of_place(10)).to contain_exactly(@map.get_field(3),
                                                              @map.get_field(9),
                                                              @map.get_field(10))
    end

    it 'knows that fields 3, 10 and 11 are nearby place 11' do
      expect(@map.get_fields_of_place(11)).to contain_exactly(@map.get_field(3),
                                                              @map.get_field(10),
                                                              @map.get_field(11))
    end

    it 'knows that fields 3, 4 and 11 are nearby place 12' do
      expect(@map.get_fields_of_place(12)).to contain_exactly(@map.get_field(3),
                                                              @map.get_field(4),
                                                              @map.get_field(11))
    end

    it 'knows that fields 4, 11 and 12 are nearby place 13' do
      expect(@map.get_fields_of_place(13)).to contain_exactly(@map.get_field(4),
                                                              @map.get_field(11),
                                                              @map.get_field(12))
    end

    it 'knows that fields 4, 12 and 13 are nearby place 14' do
      expect(@map.get_fields_of_place(14)).to contain_exactly(@map.get_field(4),
                                                              @map.get_field(12),
                                                              @map.get_field(13))
    end

    it 'knows that fields 4, 5 and 13 are nearby place 15' do
      expect(@map.get_fields_of_place(15)).to contain_exactly(@map.get_field(4),
                                                              @map.get_field(5),
                                                              @map.get_field(13))
    end

    it 'knows that fields 5, 13 and 14 are nearby place 16' do
      expect(@map.get_fields_of_place(16)).to contain_exactly(@map.get_field(5),
                                                              @map.get_field(13),
                                                              @map.get_field(14))
    end

    it 'knows that fields 7, 17 and 18 are nearby place 22' do
      expect(@map.get_fields_of_place(22)).to contain_exactly(@map.get_field(7),
                                                              @map.get_field(17),
                                                              @map.get_field(18))
    end

    it 'knows that fields 7, 18 and 19 are nearby place 23' do
      expect(@map.get_fields_of_place(23)).to contain_exactly(@map.get_field(7),
                                                              @map.get_field(18),
                                                              @map.get_field(19))
    end

    it 'knows that fields 2, 7 and 19 are nearby place 24' do
      expect(@map.get_fields_of_place(24)).to contain_exactly(@map.get_field(2),
                                                              @map.get_field(7),
                                                              @map.get_field(19))
    end

    it 'knows that field 8 is nearby place 25' do
      expect(@map.get_fields_of_place(25)).to contain_exactly(@map.get_field(8))
    end

    it 'knows that field 8 is nearby place 26' do
      expect(@map.get_fields_of_place(26)).to contain_exactly(@map.get_field(8))
    end

    it 'knows that fields 8 and 9 are nearby place 27' do
      expect(@map.get_fields_of_place(27)).to contain_exactly(@map.get_field(8),
                                                              @map.get_field(9))
    end

    it 'knows that field 9 is nearby place 28' do
      expect(@map.get_fields_of_place(28)).to contain_exactly(@map.get_field(9))
    end

    it 'knows that fields 9 and 10 are nearby place 29' do
      expect(@map.get_fields_of_place(29)).to contain_exactly(@map.get_field(9),
                                                              @map.get_field(10))
    end

    it 'knows that field 10 is nearby place 30' do
      expect(@map.get_fields_of_place(30)).to contain_exactly(@map.get_field(10))
    end

    it 'knows that field 10 is nearby place 31' do
      expect(@map.get_fields_of_place(31)).to contain_exactly(@map.get_field(10))
    end

    it 'knows that fields 10 and 11 are nearby place 32' do
      expect(@map.get_fields_of_place(32)).to contain_exactly(@map.get_field(10),
                                                              @map.get_field(11))
    end

    it 'knows that field 11 is nearby place 33' do
      expect(@map.get_fields_of_place(33)).to contain_exactly(@map.get_field(11))
    end

    it 'knows that fields 11 and 12 are nearby place 34' do
      expect(@map.get_fields_of_place(34)).to contain_exactly(@map.get_field(11),
                                                              @map.get_field(12))
    end

    it 'knows that field 12 is nearby place 35' do
      expect(@map.get_fields_of_place(35)).to contain_exactly(@map.get_field(12))
    end

    it 'knows that field 12 is nearby place 36' do
      expect(@map.get_fields_of_place(36)).to contain_exactly(@map.get_field(12))
    end

    it 'knows that fields 12 and 13 are nearby place 37' do
      expect(@map.get_fields_of_place(37)).to contain_exactly(@map.get_field(12),
                                                              @map.get_field(13))
    end

    it 'knows that field 13 is nearby place 38' do
      expect(@map.get_fields_of_place(38)).to contain_exactly(@map.get_field(13))
    end

    it 'knows that fields 13 and 14 are nearby place 39' do
      expect(@map.get_fields_of_place(39)).to contain_exactly(@map.get_field(13),
                                                              @map.get_field(14))
    end

    it 'knows that field 18 is nearby place 50' do
      expect(@map.get_fields_of_place(50)).to contain_exactly(@map.get_field(18))
    end

    it 'knows that field 18 is nearby place 51' do
      expect(@map.get_fields_of_place(51)).to contain_exactly(@map.get_field(18))
    end

    it 'knows that fields 18 and 19 are nearby place 52' do
      expect(@map.get_fields_of_place(52)).to contain_exactly(@map.get_field(18),
                                                              @map.get_field(19))
    end

    it 'knows that field 19 is nearby place 53' do
      expect(@map.get_fields_of_place(53)).to contain_exactly(@map.get_field(19))
    end

    it 'knows that fields 8 and 19 are nearby place 54' do
      expect(@map.get_fields_of_place(54)).to contain_exactly(@map.get_field(8),
                                                              @map.get_field(19))
    end

    it 'fails when try to get too low-numbered fields of place' do
      expect{ @map.get_fields_of_place(0) }.to raise_error(Map::BeyondRangeError)
    end

    it 'fails when try to get too high-numbered fields of place' do
      expect{ @map.get_fields_of_place(55) }.to raise_error(Map::BeyondRangeError)
    end

    it 'returns nil when try to get nil fields of place' do
      expect(@map.get_fields_of_place(nil)).to be_nil
    end

    it 'knows that places 1, 2, 3, 4, 5 and 6 are nearby field 1' do
      expect(@map.get_places_of_field(1)).to contain_exactly(@map.get_place(1),
                                                             @map.get_place(2),
                                                             @map.get_place(3),
                                                             @map.get_place(4),
                                                             @map.get_place(5),
                                                             @map.get_place(6))
    end

    it 'knows that places 1, 2, 7, 8, 9 and 24 are nearby field 2' do
      expect(@map.get_places_of_field(2)).to contain_exactly(@map.get_place(1),
                                                             @map.get_place(2),
                                                             @map.get_place(7),
                                                             @map.get_place(8),
                                                             @map.get_place(9),
                                                             @map.get_place(24))
    end

    it 'knows that places 4, 5, 15, 16, 17 and 18 are nearby field 5' do
      expect(@map.get_places_of_field(5)).to contain_exactly(@map.get_place(4),
                                                             @map.get_place(5),
                                                             @map.get_place(15),
                                                             @map.get_place(16),
                                                             @map.get_place(17),
                                                             @map.get_place(18))
    end

    it 'knows that places 7, 8, 25, 26, 27 and 54 are nearby field 8' do
      expect(@map.get_places_of_field(8)).to contain_exactly(@map.get_place(7),
                                                             @map.get_place(8),
                                                             @map.get_place(25),
                                                             @map.get_place(26),
                                                             @map.get_place(27),
                                                             @map.get_place(54))
    end

    it 'knows that places 13, 14, 34, 35, 36 and 37 are nearby field 12' do
      expect(@map.get_places_of_field(12)).to contain_exactly(@map.get_place(13),
                                                              @map.get_place(14),
                                                              @map.get_place(34),
                                                              @map.get_place(35),
                                                              @map.get_place(36),
                                                              @map.get_place(37))
    end

    it 'knows that places 7, 23, 24, 52, 53 and 54 are nearby field 19' do
      expect(@map.get_places_of_field(19)).to contain_exactly(@map.get_place(7),
                                                              @map.get_place(23),
                                                              @map.get_place(24),
                                                              @map.get_place(52),
                                                              @map.get_place(53),
                                                              @map.get_place(54))
    end

    it 'fails when try to get too low-numbered places of field' do
      expect{ @map.get_places_of_field(0) }.to raise_error(Map::BeyondRangeError)
    end

    it 'fails when try to get too high-numbered places of field' do
      expect{ @map.get_places_of_field(20) }.to raise_error(Map::BeyondRangeError)
    end

    it 'returns nil when try to get nil places of field' do
      expect(@map.get_places_of_field(nil)).to be_nil
    end

    it 'assigns a resource to every field' do
      (1..@map.fields_count).each do |index|
        expect(@map.get_field(index)).to respond_to(:resource)
      end
    end

    it 'assigns desert to 1 field resource' do
      expect(@map.get_field(:first).resource).to eq(:desert)
    end

    it 'assigns a valid resource to every field except first' do
      (2..@map.fields_count).each do |index|
        expect(valid_resources).to include(@map.get_field(index).resource)
      end
    end
  end
end