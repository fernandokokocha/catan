describe EndTurn do
  let(:turn) { 1 }
  let(:first_player) { Player.new('Bartek', :orange) }
  let(:second_player) { Player.new('Walo', :red) }
  let(:players) { [first_player, second_player] }
  let(:current_player) { first_player }
  let(:valid_request) do
    { turn: turn,
      players: players,
      current_player: current_player }
  end

  it 'raises error if request is nil' do
    request = nil
    expect { EndTurn.new(request).invoke }.to raise_error(
      Controller::InvalidParameters,
      'Params is not a hash'
    )
  end

  it 'raises error if request is not a hash' do
    request = []
    expect { EndTurn.new(request).invoke }.to raise_error(
      Controller::InvalidParameters,
      'Params is not a hash'
    )
  end

  it 'requires turn' do
    request = valid_request
    request.delete(:turn)
    expect { EndTurn.new(request).invoke }.to raise_error(
      Controller::InvalidParameters,
      'Missing :turn key in params'
    )
  end

  it 'raises error if turn is nil' do
    request = valid_request
    request[:turn] = nil
    expect { EndTurn.new(request).invoke }.to raise_error(
      Controller::InvalidParameters,
      ':turn value is not of type Integer'
    )
  end

  it 'raises error if turn is NaN' do
    request = valid_request
    request[:turn] = 'First'
    expect { EndTurn.new(request).invoke }.to raise_error(
      Controller::InvalidParameters,
      ':turn value is not of type Integer'
    )
  end

  it 'requires players' do
    request = valid_request
    request.delete(:players)
    expect { EndTurn.new(request).invoke }.to raise_error(
      Controller::InvalidParameters,
      'Missing :players key in params'
    )
  end

  it 'raises error if players is nil' do
    request = valid_request
    request[:players] = nil
    expect { EndTurn.new(request).invoke }.to raise_error(
      Controller::InvalidParameters,
      ':players value is not of type Array'
    )
  end

  it 'raises error if players is not array' do
    request = valid_request
    request[:players] = first_player
    expect { EndTurn.new(request).invoke }.to raise_error(
      Controller::InvalidParameters,
      ':players value is not of type Array'
    )
  end

  it 'raises error if players is empty array' do
    request = valid_request
    request[:players] = []
    expect { EndTurn.new(request).invoke }.to raise_error(
      Controller::InvalidParameters,
      ':players value is empty array'
    )
  end

  it 'raises error if players contains nil' do
    request = valid_request
    request[:players] = [first_player, nil]
    expect { EndTurn.new(request).invoke }.to raise_error(
      Controller::InvalidParameters,
      'Illegal entry in :players value'
    )
  end

  it 'raises error if players contains not a Player' do
    request = valid_request
    request[:players] = [first_player, "Let me play, I'm a player"]
    expect { EndTurn.new(request).invoke }.to raise_error(
      Controller::InvalidParameters,
      'Illegal entry in :players value'
    )
  end

  it 'requires current_player' do
    request = valid_request
    request.delete(:current_player)
    expect { EndTurn.new(request).invoke }.to raise_error(
      Controller::InvalidParameters,
      'Missing :current_player key in params'
    )
  end

  it 'raises error if current_player is nil' do
    request = valid_request
    request[:current_player] = nil
    expect { EndTurn.new(request).invoke }.to raise_error(
      Controller::InvalidParameters,
      ':current_player value is not a Player'
    )
  end

  it 'raises error if current_player is not a player' do
    request = valid_request
    request[:current_player] = "Let me play, I'm a player"
    expect { EndTurn.new(request).invoke }.to raise_error(
      Controller::InvalidParameters,
      ':current_player value is not a Player'
    )
  end

  it 'raises error if players does not contain current_player' do
    request = valid_request
    request[:current_player] = Player.new('Marcin', :white)
    expect { EndTurn.new(request).invoke }.to raise_error(
      Controller::InvalidParameters,
      'Current player not present in players list'
    )
  end

  it 'raises error if current_player is equal not the same as a player' do
    request = valid_request
    request[:current_player] = Player.new('Wojtas', :orange)
    expect { EndTurn.new(request).invoke }.to raise_error(Controller::InvalidParameters)
  end

  context 'when valid request' do
    subject { EndTurn.new(valid_request).invoke }

    it 'works in place' do
      before = valid_request
      subject
      expect(valid_request).to eq(before)
    end

    it 'increments turns' do
      expect(subject[:turn]).to eq(turn + 1)
    end

    context 'when 2 players' do
      context 'when first turn' do
        it 'makes second player current' do
          expect(subject[:current_player]).to be(second_player)
        end

        context 'when second player is current' do
          let(:current_player) { second_player }

          it 'makes first player current' do
            expect(subject[:current_player]).to be(first_player)
          end
        end
      end

      context 'when second turn' do
        let(:turn) { 2 }

        it 'does not change current player' do
          expect(subject[:current_player]).to be(first_player)
        end

        context 'when second player is current' do
          let(:current_player) { second_player }

          it 'does not change current player' do
            expect(subject[:current_player]).to be(second_player)
          end
        end
      end

      context 'when third turn' do
        let(:turn) { 3 }

        it 'makes second player current' do
          expect(subject[:current_player]).to be(second_player)
        end

        context 'when second player is current' do
          let(:current_player) { second_player }

          it 'makes first player current' do
            expect(subject[:current_player]).to be(first_player)
          end
        end
      end

      context 'when fourth turn' do
        let(:turn) { 4 }

        it 'makes second player current' do
          expect(subject[:current_player]).to be(second_player)
        end

        context 'when second player is current' do
          let(:current_player) { second_player }

          it 'makes first player current' do
            expect(subject[:current_player]).to be(first_player)
          end
        end
      end
    end

    context 'when 3 players' do
      let(:third_player) { Player.new('Spejson', :white) }
      let(:players) { [first_player, second_player, third_player] }

      context 'when first turn' do
        context 'when second player is current' do
          let(:current_player) { second_player }

          it 'makes third player current' do
            expect(subject[:current_player]).to be(third_player)
          end
        end

        context 'when third player is current' do
          let(:current_player) { third_player }

          it 'makes first player current' do
            expect(subject[:current_player]).to be(first_player)
          end
        end
      end

      context 'when second turn' do
        let(:turn) { 2 }

        context 'when first player is current' do
          let(:current_player) { first_player }

          it 'makes second player current' do
            expect(subject[:current_player]).to be(second_player)
          end
        end

        context 'when third player is current' do
          let(:current_player) { third_player }

          it 'makes first player current' do
            expect(subject[:current_player]).to be(first_player)
          end
        end
      end

      context 'when third turn' do
        let(:turn) { 3 }

        context 'when first player is current' do
          let(:current_player) { first_player }

          it 'does not change current player' do
            expect(subject[:current_player]).to be(first_player)
          end
        end

        context 'when second player is current' do
          let(:current_player) { second_player }

          it 'does not change current player' do
            expect(subject[:current_player]).to be(second_player)
          end
        end

        context 'when third player is current' do
          let(:current_player) { third_player }

          it 'does not change current player' do
            expect(subject[:current_player]).to be(third_player)
          end
        end
      end

      context 'when fourth turn' do
        let(:turn) { 4 }

        context 'when first player is current' do
          let(:current_player) { first_player }

          it 'makes third player current' do
            expect(subject[:current_player]).to be(third_player)
          end
        end

        context 'when second player is current' do
          let(:current_player) { second_player }

          it 'makes first player current' do
            expect(subject[:current_player]).to be(first_player)
          end
        end

        context 'when third player is current' do
          let(:current_player) { third_player }

          it 'makes second player current' do
            expect(subject[:current_player]).to be(second_player)
          end
        end
      end

      context 'when 6th turn' do
        let(:turn) { 6 }

        context 'when first player is current' do
          let(:current_player) { first_player }

          it 'makes second player current' do
            expect(subject[:current_player]).to be(second_player)
          end
        end

        context 'when second player is current' do
          let(:current_player) { second_player }

          it 'makes third player current' do
            expect(subject[:current_player]).to be(third_player)
          end
        end

        context 'when third player is current' do
          let(:current_player) { third_player }

          it 'makes first player current' do
            expect(subject[:current_player]).to be(first_player)
          end
        end
      end
    end
  end
end
