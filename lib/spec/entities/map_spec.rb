describe Map do
  let(:valid_player) { Player.new('Bartek', :orange) }
  let(:valid_place) { 1 }
  let(:valid_neighbour) { 2 }
  let(:valid_place2) { 3 }
  let(:valid_neighbour2) { 6 }

  before (:each) do
    @map = Map.new
  end

  it 'has 3 layers' do
    expect(@map.layers_count).to eq(3)
  end

  it 'has proper number of places' do
    expect(@map.places_count).to eq(54)
  end

  it 'can get every place by its index' do
    (1..@map.places_count).each do |index|
      expect(@map.place(index)).to be_instance_of(Place)
    end
  end

  it 'has every place numbered' do
    (1..@map.places_count).each do |index|
      expect(@map.place(index).index).to eq(index)
    end
  end

  describe '#place' do
    it 'fails when try to get nil-place' do
      expect{ @map.place(nil) }.to raise_error(Map::WrongIndexError)
    end

    it 'fails when try to get too low-numbered place' do
      expect{ @map.place(0) }.to raise_error(Map::WrongIndexError)
    end

    it 'fails when try to get too high-numbered place' do
      expect{ @map.place(55) }.to raise_error(Map::WrongIndexError)
    end

    it 'has first place in layer 1' do
      expect(@map.place(1).layer).to eq(1)
    end

    it 'has second place in layer 1' do
      expect(@map.place(2).layer).to eq(1)
    end

    it 'has 6th place in layer 2' do
      expect(@map.place(6).layer).to eq(1)
    end

    it 'has 7th place in layer 2' do
      expect(@map.place(7).layer).to eq(2)
    end

    it 'has 24th place in layer 2' do
      expect(@map.place(24).layer).to eq(2)
    end

    it 'has 25th place in layer 3' do
      expect(@map.place(25).layer).to eq(3)
    end

    it 'has 54nd (last) place in layer 3' do
      expect(@map.place(54).layer).to eq(3)
    end

    it 'has first place in side 1' do
      expect(@map.place(1).side).to eq(1)
    end

    it 'has second place in side 2' do
      expect(@map.place(2).side).to eq(2)
    end

    it 'has 6th place in side 6' do
      expect(@map.place(6).side).to eq(6)
    end

    it 'has 7th place in side 1' do
      expect(@map.place(7).side).to eq(1)
    end

    it 'has 8th place in side 1' do
      expect(@map.place(8).side).to eq(1)
    end

    it 'has 9th place in side 1' do
      expect(@map.place(9).side).to eq(1)
    end

    it 'has 10th place in side 2' do
      expect(@map.place(10).side).to eq(2)
    end

    it 'has 12th place in side 2' do
      expect(@map.place(12).side).to eq(2)
    end

    it 'has 13th place in side 3' do
      expect(@map.place(13).side).to eq(3)
    end

    it 'has 24th place in side 6' do
      expect(@map.place(24).side).to eq(6)
    end

    it 'has 25th place in side 1' do
      expect(@map.place(25).side).to eq(1)
    end

    it 'has 29th place in side 1' do
      expect(@map.place(29).side).to eq(1)
    end

    it 'has 30th place in side 2' do
      expect(@map.place(30).side).to eq(2)
    end

    it 'has 34th place in side 2' do
      expect(@map.place(34).side).to eq(2)
    end

    it 'has 35th place in side 3' do
      expect(@map.place(35).side).to eq(3)
    end

    it 'has first place in spot 1' do
      expect(@map.place(1).spot).to eq(1)
    end

    it 'has second place in spot 1' do
      expect(@map.place(2).spot).to eq(1)
    end

    it 'has 7th place in spot 1' do
      expect(@map.place(7).spot).to eq(1)
    end

    it 'has 8th place in spot 2' do
      expect(@map.place(8).spot).to eq(2)
    end

    it 'has 9th place in spot 3' do
      expect(@map.place(9).spot).to eq(3)
    end

    it 'has 10th place in spot 1' do
      expect(@map.place(10).spot).to eq(1)
    end

    it 'has 13th place in spot 1' do
      expect(@map.place(13).spot).to eq(1)
    end

    it 'has 24th place in spot 6' do
      expect(@map.place(24).spot).to eq(3)
    end

    it 'has 25th place in spot 1' do
      expect(@map.place(25).spot).to eq(1)
    end

    it 'has 28th place in spot 4' do
      expect(@map.place(28).spot).to eq(4)
    end

    it 'has 29th place in spot 5' do
      expect(@map.place(29).spot).to eq(5)
    end

    it 'has 30th place in spot 1' do
      expect(@map.place(30).spot).to eq(1)
    end

    it 'has 34th place in spot 5' do
      expect(@map.place(34).spot).to eq(5)
    end

    it 'has 35th place in spot 1' do
      expect(@map.place(35).spot).to eq(1)
    end

    it 'has last place in spot 5' do
      expect(@map.place(54).spot).to eq(5)
    end

    it 'has every place with empty roads array' do
      @map.places.each do |place|
        expect(place.roads).to be_empty
      end
    end

    describe 'settlement' do
      it 'has every place unsettled' do
        @map.places.each do |place|
          expect(place.settled_by).to be_nil
        end
      end

      it 'can settle every place' do
        @map.places.each do |place|
          expect(@map.can_settle?(place.index)).to be(true)
        end
      end

      it 'assigns player after settle' do
        @map.settle_place(valid_place, valid_player)
        expect(@map.place(valid_place).settled_by).to eq(valid_player)
      end
    end
  end

  describe '#get_neighbours' do
    it 'fails when try to get neighbours of nil-place' do
      expect{ @map.get_neighbours(nil) }.to raise_error(Map::WrongIndexError)
    end

    it 'fails when try to get neighbours of too low-numbered place' do
      expect{ @map.get_neighbours(0) }.to raise_error(Map::WrongIndexError)
    end

    it 'fails when try to get neighbours of too high-numbered place' do
      expect{ @map.get_neighbours(55) }.to raise_error(Map::WrongIndexError)
    end

    it 'knows that places 2, 6 and 24 are neighbours of place 1' do
      expect(@map.get_neighbours(1)).to contain_exactly(@map.place(2),
      @map.place(6),
      @map.place(24))
    end

    it 'knows that places 1, 3 and 9 are neighbours of place 2' do
      expect(@map.get_neighbours(2)).to contain_exactly(@map.place(1),
      @map.place(3),
      @map.place(9))
    end

    it 'knows that places 2, 4 and 12 are neighbours of place 3' do
      expect(@map.get_neighbours(3)).to contain_exactly(@map.place(2),
      @map.place(4),
      @map.place(12))
    end

    it 'knows that places 5, 1 and 21 are neighbours of place 6' do
      expect(@map.get_neighbours(6)).to contain_exactly(@map.place(5),
      @map.place(1),
      @map.place(21))
    end

    it 'knows that places 8, 24 and 54 are neighbours of place 7' do
      expect(@map.get_neighbours(7)).to contain_exactly(@map.place(8),
      @map.place(24),
      @map.place(54))
    end

    it 'knows that places 7, 9 and 27 are neighbours of place 8' do
      expect(@map.get_neighbours(8)).to contain_exactly(@map.place(7),
      @map.place(9),
      @map.place(27))
    end

    it 'knows that places 2, 8 and 10 are neighbours of place 9' do
      expect(@map.get_neighbours(9)).to contain_exactly(@map.place(2),
      @map.place(8),
      @map.place(10))
    end

    it 'knows that places 9, 11 and 29 are neighbours of place 10' do
      expect(@map.get_neighbours(10)).to contain_exactly(@map.place(9),
      @map.place(11),
      @map.place(29))
    end

    it 'knows that places 10, 12 and 32 are neighbours of place 11' do
      expect(@map.get_neighbours(11)).to contain_exactly(@map.place(10),
      @map.place(12),
      @map.place(32))
    end

    it 'knows that places 3, 11 and 13 are neighbours of place 12' do
      expect(@map.get_neighbours(12)).to contain_exactly(@map.place(3),
      @map.place(11),
      @map.place(13))
    end

    it 'knows that places 22, 24 and 52 are neighbours of place 23' do
      expect(@map.get_neighbours(23)).to contain_exactly(@map.place(22),
      @map.place(24),
      @map.place(52))
    end

    it 'knows that places 1, 7 and 23 are neighbours of place 24' do
      expect(@map.get_neighbours(24)).to contain_exactly(@map.place(1),
      @map.place(7),
      @map.place(23))
    end

    it 'knows that places 26 and 54 are neighbours of place 25' do
      expect(@map.get_neighbours(25)).to contain_exactly(@map.place(26),
      @map.place(54))
    end

    it 'knows that places 25 and 27 are neighbours of place 26' do
      expect(@map.get_neighbours(26)).to contain_exactly(@map.place(25),
      @map.place(27))
    end

    it 'knows that places 8, 26 and 28 are neighbours of place 27' do
      expect(@map.get_neighbours(27)).to contain_exactly(@map.place(8),
      @map.place(26),
      @map.place(28))
    end

    it 'knows that places 27 and 29 are neighbours of place 28' do
      expect(@map.get_neighbours(28)).to contain_exactly(@map.place(27),
      @map.place(29))
    end

    it 'knows that places 10, 28 and 30 are neighbours of place 29' do
      expect(@map.get_neighbours(29)).to contain_exactly(@map.place(10),
      @map.place(28),
      @map.place(30))
    end

    it 'knows that places 29 and 31 are neighbours of place 30' do
      expect(@map.get_neighbours(30)).to contain_exactly(@map.place(29),
      @map.place(31))
    end

    it 'knows that places 11, 31 and 33 are neighbours of place 32' do
      expect(@map.get_neighbours(32)).to contain_exactly(@map.place(11),
      @map.place(31),
      @map.place(33))
    end

    it 'knows that places 13, 33 and 35 are neighbours of place 34' do
      expect(@map.get_neighbours(34)).to contain_exactly(@map.place(13),
      @map.place(33),
      @map.place(35))
    end

    it 'knows that places 23, 51 and 53 are neighbours of place 52' do
      expect(@map.get_neighbours(52)).to contain_exactly(@map.place(23),
      @map.place(51),
      @map.place(53))
    end

    it 'knows that places 52 and 54 are neighbours of place 53' do
      expect(@map.get_neighbours(53)).to contain_exactly(@map.place(52),
      @map.place(54))
    end

    it 'knows that places 7, 25 and 53 are neighbours of place 54' do
      expect(@map.get_neighbours(54)).to contain_exactly(@map.place(7),
      @map.place(25),
      @map.place(53))
    end
  end

  it 'has proper number of fields' do
    expect(@map.fields_count).to eq(1 + 6 + 12)
  end

  it 'can get every field by its index' do
    (1..@map.fields_count).each do |index|
      expect(@map.field(index)).to be_instance_of(Field)
    end
  end

  it 'has every field numbered' do
    (1..@map.fields_count).each do |index|
      expect(@map.field(index).index).to eq(index)
    end
  end

  describe '#field' do
    it 'return nil when try to get nil-field' do
      expect{ @map.field(nil) }.to raise_error(Map::WrongIndexError)
    end

    it 'fails when try to get too low-numbered field' do
      expect{ @map.field(0) }.to raise_error(Map::WrongIndexError)
    end

    it 'fails when try to get too high-numbered field' do
      expect{ @map.field(20) }.to raise_error(Map::WrongIndexError)
    end

    describe 'numbers' do
      it 'has first field with number 7' do
        expect(@map.field(1).number).to eq(7)
      end

      it 'has one field with numbers 2 and 12' do
        [2,12].each do |number|
          fields = @map.fields.each.select do |field|
            field.number == number
          end
          expect(fields.count).to eq(1)
        end
      end

      it 'has two fields with numbers 3,4,5,6,8,9,10,11' do
        [3,4,5,6,8,9,10,11].each do |number|
          fields = @map.fields.each.select do |field|
            field.number == number
          end
          expect(fields.count).to eq(2)
        end
      end
    end

    describe 'resources' do
      it 'assigns a resource to every field' do
        @map.fields.each do |field|
          expect(field).to respond_to(:resource)
        end
      end

      it 'assigns desert to 1 field resource' do
        expect(@map.field(1).resource).to eq(:desert)
      end

      it 'has 3 ore fields' do
        ore_fields = @map.fields.each.select do |field|
          field.resource == :ore
        end
        expect(ore_fields.count).to eq(3)
      end

      it 'has 3 brick fields' do
        brick_fields = @map.fields.each.select do |field|
          field.resource == :brick
        end
        expect(brick_fields.count).to eq(3)
      end

      it 'has 4 wool fields' do
        wool_fields = @map.fields.each.select do |field|
          field.resource == :wool
        end
        expect(wool_fields.count).to eq(4)
      end

      it 'has 4 grain fields' do
        grain_fields = @map.fields.each.select do |field|
          field.resource == :grain
        end
        expect(grain_fields.count).to eq(4)
      end

      it 'has 4 lumber fields' do
        lumber_fields = @map.fields.each.select do |field|
          field.resource == :lumber
        end
        expect(lumber_fields.count).to eq(4)
      end
    end
  end

  describe '#get_fields_of_place' do
    it 'knows that fields 1, 2 and 7 are nearby place 1' do
      expect(@map.get_fields_of_place(1)).to contain_exactly(@map.field(1),
      @map.field(7),
      @map.field(2))
    end

    it 'knows that fields 1, 2 and 7 are nearby place 2' do
      expect(@map.get_fields_of_place(2)).to contain_exactly(@map.field(1),
      @map.field(2),
      @map.field(3))
    end

    it 'knows that fields 1, 3 and 4 are nearby place 3' do
      expect(@map.get_fields_of_place(3)).to contain_exactly(@map.field(1),
      @map.field(3),
      @map.field(4))
    end

    it 'knows that fields 1, 6 and 7 are nearby place 6' do
      expect(@map.get_fields_of_place(6)).to contain_exactly(@map.field(1),
      @map.field(6),
      @map.field(7))
    end

    it 'knows that fields 2, 8 and 19 are nearby place 7' do
      expect(@map.get_fields_of_place(7)).to contain_exactly(@map.field(2),
      @map.field(19),
      @map.field(8))
    end

    it 'knows that fields 2, 8 and 9 are nearby place 8' do
      expect(@map.get_fields_of_place(8)).to contain_exactly(@map.field(2),
      @map.field(8),
      @map.field(9))
    end

    it 'knows that fields 2, 3 and 9 are nearby place 9' do
      expect(@map.get_fields_of_place(9)).to contain_exactly(@map.field(2),
      @map.field(3),
      @map.field(9))
    end

    it 'knows that fields 2, 3 and 9 are nearby place 10' do
      expect(@map.get_fields_of_place(10)).to contain_exactly(@map.field(3),
      @map.field(9),
      @map.field(10))
    end

    it 'knows that fields 3, 10 and 11 are nearby place 11' do
      expect(@map.get_fields_of_place(11)).to contain_exactly(@map.field(3),
      @map.field(10),
      @map.field(11))
    end

    it 'knows that fields 3, 4 and 11 are nearby place 12' do
      expect(@map.get_fields_of_place(12)).to contain_exactly(@map.field(3),
      @map.field(4),
      @map.field(11))
    end

    it 'knows that fields 4, 11 and 12 are nearby place 13' do
      expect(@map.get_fields_of_place(13)).to contain_exactly(@map.field(4),
      @map.field(11),
      @map.field(12))
    end

    it 'knows that fields 4, 12 and 13 are nearby place 14' do
      expect(@map.get_fields_of_place(14)).to contain_exactly(@map.field(4),
      @map.field(12),
      @map.field(13))
    end

    it 'knows that fields 4, 5 and 13 are nearby place 15' do
      expect(@map.get_fields_of_place(15)).to contain_exactly(@map.field(4),
      @map.field(5),
      @map.field(13))
    end

    it 'knows that fields 5, 13 and 14 are nearby place 16' do
      expect(@map.get_fields_of_place(16)).to contain_exactly(@map.field(5),
      @map.field(13),
      @map.field(14))
    end

    it 'knows that fields 7, 17 and 18 are nearby place 22' do
      expect(@map.get_fields_of_place(22)).to contain_exactly(@map.field(7),
      @map.field(17),
      @map.field(18))
    end

    it 'knows that fields 7, 18 and 19 are nearby place 23' do
      expect(@map.get_fields_of_place(23)).to contain_exactly(@map.field(7),
      @map.field(18),
      @map.field(19))
    end

    it 'knows that fields 2, 7 and 19 are nearby place 24' do
      expect(@map.get_fields_of_place(24)).to contain_exactly(@map.field(2),
      @map.field(7),
      @map.field(19))
    end

    it 'knows that field 8 is nearby place 25' do
      expect(@map.get_fields_of_place(25)).to contain_exactly(@map.field(8))
    end

    it 'knows that field 8 is nearby place 26' do
      expect(@map.get_fields_of_place(26)).to contain_exactly(@map.field(8))
    end

    it 'knows that fields 8 and 9 are nearby place 27' do
      expect(@map.get_fields_of_place(27)).to contain_exactly(@map.field(8),
      @map.field(9))
    end

    it 'knows that field 9 is nearby place 28' do
      expect(@map.get_fields_of_place(28)).to contain_exactly(@map.field(9))
    end

    it 'knows that fields 9 and 10 are nearby place 29' do
      expect(@map.get_fields_of_place(29)).to contain_exactly(@map.field(9),
      @map.field(10))
    end

    it 'knows that field 10 is nearby place 30' do
      expect(@map.get_fields_of_place(30)).to contain_exactly(@map.field(10))
    end

    it 'knows that field 10 is nearby place 31' do
      expect(@map.get_fields_of_place(31)).to contain_exactly(@map.field(10))
    end

    it 'knows that fields 10 and 11 are nearby place 32' do
      expect(@map.get_fields_of_place(32)).to contain_exactly(@map.field(10),
      @map.field(11))
    end

    it 'knows that field 11 is nearby place 33' do
      expect(@map.get_fields_of_place(33)).to contain_exactly(@map.field(11))
    end

    it 'knows that fields 11 and 12 are nearby place 34' do
      expect(@map.get_fields_of_place(34)).to contain_exactly(@map.field(11),
      @map.field(12))
    end

    it 'knows that field 12 is nearby place 35' do
      expect(@map.get_fields_of_place(35)).to contain_exactly(@map.field(12))
    end

    it 'knows that field 12 is nearby place 36' do
      expect(@map.get_fields_of_place(36)).to contain_exactly(@map.field(12))
    end

    it 'knows that fields 12 and 13 are nearby place 37' do
      expect(@map.get_fields_of_place(37)).to contain_exactly(@map.field(12),
      @map.field(13))
    end

    it 'knows that field 13 is nearby place 38' do
      expect(@map.get_fields_of_place(38)).to contain_exactly(@map.field(13))
    end

    it 'knows that fields 13 and 14 are nearby place 39' do
      expect(@map.get_fields_of_place(39)).to contain_exactly(@map.field(13),
      @map.field(14))
    end

    it 'knows that field 18 is nearby place 50' do
      expect(@map.get_fields_of_place(50)).to contain_exactly(@map.field(18))
    end

    it 'knows that field 18 is nearby place 51' do
      expect(@map.get_fields_of_place(51)).to contain_exactly(@map.field(18))
    end

    it 'knows that fields 18 and 19 are nearby place 52' do
      expect(@map.get_fields_of_place(52)).to contain_exactly(@map.field(18),
      @map.field(19))
    end

    it 'knows that field 19 is nearby place 53' do
      expect(@map.get_fields_of_place(53)).to contain_exactly(@map.field(19))
    end

    it 'knows that fields 8 and 19 are nearby place 54' do
      expect(@map.get_fields_of_place(54)).to contain_exactly(@map.field(8),
      @map.field(19))
    end

    it 'fails when try to get too low-numbered fields of place' do
      expect{ @map.get_fields_of_place(0) }.to raise_error(Map::WrongIndexError)
    end

    it 'fails when try to get too high-numbered fields of place' do
      expect{ @map.get_fields_of_place(55) }.to raise_error(Map::WrongIndexError)
    end

    it 'returns nil when try to get nil fields of place' do
      expect{ @map.get_fields_of_place(nil) }.to raise_error(Map::WrongIndexError)
    end
  end

  describe '#get_places_of_field' do
    it 'knows that places 1, 2, 3, 4, 5 and 6 are nearby field 1' do
      expect(@map.get_places_of_field(1)).to contain_exactly(@map.place(1),
      @map.place(2),
      @map.place(3),
      @map.place(4),
      @map.place(5),
      @map.place(6))
    end

    it 'knows that places 1, 2, 7, 8, 9 and 24 are nearby field 2' do
      expect(@map.get_places_of_field(2)).to contain_exactly(@map.place(1),
      @map.place(2),
      @map.place(7),
      @map.place(8),
      @map.place(9),
      @map.place(24))
    end

    it 'knows that places 4, 5, 15, 16, 17 and 18 are nearby field 5' do
      expect(@map.get_places_of_field(5)).to contain_exactly(@map.place(4),
      @map.place(5),
      @map.place(15),
      @map.place(16),
      @map.place(17),
      @map.place(18))
    end

    it 'knows that places 7, 8, 25, 26, 27 and 54 are nearby field 8' do
      expect(@map.get_places_of_field(8)).to contain_exactly(@map.place(7),
      @map.place(8),
      @map.place(25),
      @map.place(26),
      @map.place(27),
      @map.place(54))
    end

    it 'knows that places 13, 14, 34, 35, 36 and 37 are nearby field 12' do
      expect(@map.get_places_of_field(12)).to contain_exactly(@map.place(13),
      @map.place(14),
      @map.place(34),
      @map.place(35),
      @map.place(36),
      @map.place(37))
    end

    it 'knows that places 7, 23, 24, 52, 53 and 54 are nearby field 19' do
      expect(@map.get_places_of_field(19)).to contain_exactly(@map.place(7),
      @map.place(23),
      @map.place(24),
      @map.place(52),
      @map.place(53),
      @map.place(54))
    end

    it 'fails when try to get too low-numbered places of field' do
      expect{ @map.get_places_of_field(0) }.to raise_error(Map::WrongIndexError)
    end

    it 'fails when try to get too high-numbered places of field' do
      expect{ @map.get_places_of_field(20) }.to raise_error(Map::WrongIndexError)
    end

    it 'returns nil when try to get nil places of field' do
      expect{ @map.get_places_of_field(nil) }.to raise_error(Map::WrongIndexError)
    end
  end

  describe '#build_road' do
    it 'assigns valid_player to place roads after build' do
      @map.build_road(valid_place, valid_neighbour, valid_player)
      expect(@map.place(valid_place).roads).to contain_exactly([valid_neighbour, valid_player])
    end

    it 'assigns valid_player to neighbour roads after build' do
      @map.build_road(valid_place, valid_neighbour, valid_player)
      expect(@map.place(valid_neighbour).roads).to contain_exactly([valid_place, valid_player])
    end

    it 'appends other roads' do
      @map.build_road(valid_place, valid_neighbour, valid_player)
      @map.build_road(valid_place, valid_neighbour2, valid_player)
      expect(@map.place(valid_place).roads).to contain_exactly([valid_neighbour, valid_player],
                                                                   [valid_neighbour2, valid_player])
    end

    it 'appends other roads for neighbour' do
      @map.build_road(valid_place, valid_neighbour, valid_player)
      @map.build_road(valid_place2, valid_neighbour, valid_player)
      expect(@map.place(valid_neighbour).roads).to contain_exactly([valid_place, valid_player],
                                                                       [valid_place2, valid_player])
    end
  end
end
