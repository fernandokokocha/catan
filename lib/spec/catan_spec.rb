require 'spec_helper'

describe Catan do
  before (:each) do
    @app = Catan.new
  end

  it 'loads map' do
    expect{ @app.send :map }.not_to raise_error
  end

  it 'loads players' do
    expect{ @app.send :players }.not_to raise_error
  end

end