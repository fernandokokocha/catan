require 'spec_helper'

describe Catan do
  it 'loads  map' do
    app = Catan.new
    expect(app.map).to be_instance_of(Map)
  end

end