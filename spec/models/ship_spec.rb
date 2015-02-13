require "spec_helper"

describe Ship do
  let(:board) { FactoryGirl.create(:board) }
  let(:ship)  { board.ships.first }

  it "references its board" do
    expect(ship.board).to eq board
  end

  it "has length 5 when name=carrier" do
    ship.name = "carrier"
    expect(ship.length).to eq 5
  end

  it "has length 4 when name=battleship" do
    ship.name = "battleship"
    expect(ship.length).to eq 4
  end

  it "has length 3 when name=submarine" do
    ship.name = "submarine"
    expect(ship.length).to eq 3
  end

  it "has length 3 when name=destroyer" do
    ship.name = "destroyer"
    expect(ship.length).to eq 3
  end

  it "has length 2 when name=patrol_boat" do
    ship.name = "patrol_boat"
    expect(ship.length).to eq 2
  end
end
