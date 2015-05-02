require 'spec_helper'

describe Catan do
  before (:each) do
    @app = Catan.new
  end

  it 'loads map' do
    expect(@app).to respond_to(:map)
  end

  it 'loads players' do
    expect(@app).to respond_to(:players)
  end

  it 'loads order' do
    expect(@app).to respond_to(:order)
  end
end