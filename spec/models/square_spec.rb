require "spec_helper"

describe Square do
  let(:square) { Square.new(:x => "A", :y => 1) }

  it "has an x coordinate" do
    expect(square.x).to eq "A"
  end
end
