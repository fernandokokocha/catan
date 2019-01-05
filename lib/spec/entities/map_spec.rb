describe Map do
  let(:valid_player) { Player.new('Bartek', :orange) }
  let(:valid_place) { 1 }
  let(:valid_neighbour) { 2 }
  let(:valid_place2) { 3 }
  let(:valid_neighbour2) { 6 }

  before(:each) do
    @map = Map.new
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
      expect { @map.place(nil) }.to raise_error(Map::WrongIndexError)
    end

    it 'fails when try to get too low-numbered place' do
      expect { @map.place(0) }.to raise_error(Map::WrongIndexError)
    end

    it 'fails when try to get too high-numbered place' do
      expect { @map.place(55) }.to raise_error(Map::WrongIndexError)
    end

    describe 'layers' do
      def self.expect_place_in_layer(place_index, layer_number)
        it "has place no. #{place_index} in layer #{layer_number}" do
          expect(@map.place(place_index).layer).to eq(layer_number)
        end
      end

      expect_place_in_layer(1, 1)
      expect_place_in_layer(2, 1)
      expect_place_in_layer(6, 1)
      expect_place_in_layer(7, 2)
      expect_place_in_layer(24, 2)
      expect_place_in_layer(25, 3)
      expect_place_in_layer(54, 3)
    end

    describe 'sides' do
      def self.expect_place_in_side(place_index, side_number)
        it "has place no. #{place_index} in side #{side_number}" do
          expect(@map.place(place_index).side).to eq(side_number)
        end
      end

      expect_place_in_side(1, 1)
      expect_place_in_side(2, 2)
      expect_place_in_side(6, 6)
      expect_place_in_side(7, 1)
      expect_place_in_side(8, 1)
      expect_place_in_side(9, 1)
      expect_place_in_side(10, 2)
      expect_place_in_side(12, 2)
      expect_place_in_side(13, 3)
      expect_place_in_side(24, 6)
      expect_place_in_side(25, 1)
      expect_place_in_side(29, 1)
      expect_place_in_side(30, 2)
      expect_place_in_side(34, 2)
      expect_place_in_side(35, 3)
    end

    describe 'spots' do
      def self.expect_place_in_spot(place_index, spot_number)
        it "has place no. #{place_index} in spot #{spot_number}" do
          expect(@map.place(place_index).spot).to eq(spot_number)
        end
      end

      expect_place_in_spot(1, 1)
      expect_place_in_spot(1, 1)
      expect_place_in_spot(7, 1)
      expect_place_in_spot(8, 2)
      expect_place_in_spot(9, 3)
      expect_place_in_spot(10, 1)
      expect_place_in_spot(13, 1)
      expect_place_in_spot(24, 3)
      expect_place_in_spot(25, 1)
      expect_place_in_spot(28, 4)
      expect_place_in_spot(29, 5)
      expect_place_in_spot(30, 1)
      expect_place_in_spot(34, 5)
      expect_place_in_spot(35, 1)
      expect_place_in_spot(54, 5)
    end

    describe 'roads' do
      it 'has every place with empty roads array' do
        @map.places.each do |place|
          expect(place.roads).to be_empty
        end
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
      expect { @map.get_neighbours(nil) }.to raise_error(Map::WrongIndexError)
    end

    it 'fails when try to get neighbours of too low-numbered place' do
      expect { @map.get_neighbours(0) }.to raise_error(Map::WrongIndexError)
    end

    it 'fails when try to get neighbours of too high-numbered place' do
      expect { @map.get_neighbours(55) }.to raise_error(Map::WrongIndexError)
    end

    def self.expect_neighbours(place_index, neighbour_indexes)
      it "knows that place no. #{place_index} neighbours with #{neighbour_indexes.join(', ')}" do
        neighbours = neighbour_indexes.map { |index| @map.place(index) }
        expect(@map.get_neighbours(place_index)).to match_array(neighbours)
      end
    end

    expect_neighbours(1, [2, 6, 24])
    expect_neighbours(2, [1, 3, 9])
    expect_neighbours(3, [2, 4, 12])
    expect_neighbours(6, [5, 1, 21])
    expect_neighbours(7, [8, 24, 54])
    expect_neighbours(8, [7, 9, 27])
    expect_neighbours(9, [2, 8, 10])
    expect_neighbours(10, [9, 11, 29])
    expect_neighbours(11, [10, 12, 32])
    expect_neighbours(12, [3, 11, 13])
    expect_neighbours(23, [22, 24, 52])
    expect_neighbours(24, [1, 7, 23])
    expect_neighbours(25, [26, 54])
    expect_neighbours(26, [25, 27])
    expect_neighbours(27, [8, 26, 28])
    expect_neighbours(28, [27, 29])
    expect_neighbours(29, [10, 28, 30])
    expect_neighbours(30, [29, 31])
    expect_neighbours(32, [11, 31, 33])
    expect_neighbours(34, [13, 33, 35])
    expect_neighbours(52, [23, 51, 53])
    expect_neighbours(53, [52, 54])
    expect_neighbours(54, [7, 25, 53])
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
      expect { @map.field(nil) }.to raise_error(Map::WrongIndexError)
    end

    it 'fails when try to get too low-numbered field' do
      expect { @map.field(0) }.to raise_error(Map::WrongIndexError)
    end

    it 'fails when try to get too high-numbered field' do
      expect { @map.field(20) }.to raise_error(Map::WrongIndexError)
    end

    describe 'numbers' do
      it 'has first field with number 7' do
        expect(@map.field(1).number).to eq(7)
      end

      it 'has one field with numbers 2 and 12' do
        [2, 12].each do |number|
          fields = @map.fields.each.select do |field|
            field.number == number
          end
          expect(fields.count).to eq(1)
        end
      end

      it 'has two fields with numbers 3,4,5,6,8,9,10,11' do
        [3, 4, 5, 6, 8, 9, 10, 11].each do |number|
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
    it 'fails when try to get too low-numbered fields of place' do
      expect { @map.get_fields_of_place(0) }.to raise_error(Map::WrongIndexError)
    end

    it 'fails when try to get too high-numbered fields of place' do
      expect { @map.get_fields_of_place(55) }.to raise_error(Map::WrongIndexError)
    end

    it 'returns nil when try to get nil fields of place' do
      expect { @map.get_fields_of_place(nil) }.to raise_error(Map::WrongIndexError)
    end

    def self.expect_fields_of_place(place_index, fields_indexes)
      it "knows that nearby place no. #{place_index} are fields #{fields_indexes.join(', ')}" do
        fields = fields_indexes.map { |index| @map.field(index) }
        expect(@map.get_fields_of_place(place_index)).to match_array(fields)
      end
    end

    expect_fields_of_place(1, [1, 7, 2])
    expect_fields_of_place(2, [1, 2, 3])
    expect_fields_of_place(3, [1, 3, 4])
    expect_fields_of_place(6, [1, 6, 7])
    expect_fields_of_place(7, [2, 19, 8])
    expect_fields_of_place(8, [2, 8, 9])
    expect_fields_of_place(9, [2, 3, 9])
    expect_fields_of_place(10, [3, 9, 10])
    expect_fields_of_place(11, [3, 10, 11])
    expect_fields_of_place(12, [3, 4, 11])
    expect_fields_of_place(13, [4, 11, 12])
    expect_fields_of_place(14, [4, 12, 13])
    expect_fields_of_place(15, [4, 5, 13])
    expect_fields_of_place(16, [5, 13, 14])
    expect_fields_of_place(22, [7, 17, 18])
    expect_fields_of_place(23, [7, 18, 19])
    expect_fields_of_place(24, [2, 7, 19])
    expect_fields_of_place(25, [8])
    expect_fields_of_place(26, [8])
    expect_fields_of_place(27, [8, 9])
    expect_fields_of_place(28, [9])
    expect_fields_of_place(29, [9, 10])
    expect_fields_of_place(30, [10])
    expect_fields_of_place(31, [10])
    expect_fields_of_place(32, [10, 11])
    expect_fields_of_place(33, [11])
    expect_fields_of_place(34, [11, 12])
    expect_fields_of_place(35, [12])
    expect_fields_of_place(36, [12])
    expect_fields_of_place(37, [12, 13])
    expect_fields_of_place(38, [13])
    expect_fields_of_place(39, [13, 14])
    expect_fields_of_place(50, [18])
    expect_fields_of_place(51, [18])
    expect_fields_of_place(52, [18, 19])
    expect_fields_of_place(53, [19])
    expect_fields_of_place(54, [8, 19])
  end

  describe '#get_places_of_field' do
    it 'fails when try to get too low-numbered places of field' do
      expect { @map.get_places_of_field(0) }.to raise_error(Map::WrongIndexError)
    end

    it 'fails when try to get too high-numbered places of field' do
      expect { @map.get_places_of_field(20) }.to raise_error(Map::WrongIndexError)
    end

    it 'returns nil when try to get nil places of field' do
      expect { @map.get_places_of_field(nil) }.to raise_error(Map::WrongIndexError)
    end

    def self.expect_places_of_field(field_index, places_indexes)
      it "knows that nearby field no. #{field_index} are places #{places_indexes.join(', ')}" do
        places = places_indexes.map { |index| @map.place(index) }
        expect(@map.get_places_of_field(field_index)).to match_array(places)
      end
    end

    expect_places_of_field(1, [1, 2, 3, 4, 5, 6])
    expect_places_of_field(2, [1, 2, 7, 8, 9, 24])
    expect_places_of_field(5, [4, 5, 15, 16, 17, 18])
    expect_places_of_field(8, [7, 8, 25, 26, 27, 54])
    expect_places_of_field(12, [13, 14, 34, 35, 36, 37])
    expect_places_of_field(19, [7, 23, 24, 52, 53, 54])
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
