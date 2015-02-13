require "spec_helper"

describe Board do
  let(:board) { FactoryGirl.create(:board) }

  it "has 100 squares" do
    expect(board.squares.length).to eq 100
  end

  it "has five ships" do
    expect(board.ships.length).to eq 5
  end
end
