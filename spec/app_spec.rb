require 'spec_helper'

describe App do
  it 'loads  map' do
    app = App.new
    expect(app.map).to be_instance_of(Map)
  end

end