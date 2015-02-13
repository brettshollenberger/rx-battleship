require "spec_helper"

describe Square do
  let(:board) { FactoryGirl.create(:board) }
  let(:square) { board.squares.first }

  it "has an x coordinate" do
    expect(square.x).to eq "A"
  end

  it "has a y coordinate" do
    expect(square.y).to eq 1
  end

  it "references the board it belongs to" do
    expect(square.board).to eq board
  end
end
