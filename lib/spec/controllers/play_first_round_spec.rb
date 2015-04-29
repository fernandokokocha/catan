require 'spec_helper'

describe PlayFirstRound do
  it 'raises error if passed nil' do
    request = nil
    expect{ PlayFirstRound.new(request).invoke }.to raise_error(PlayFirstRound::InvalidParameters)
  end

  it 'raises error if request is not a hash' do
    request = []
    expect{ PlayFirstRound.new(request).invoke }.to raise_error(PlayFirstRound::InvalidParameters)
  end
end