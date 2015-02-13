require "spec_helper"

describe Board do
  let(:board) { FactoryGirl.create(:board) }

  it "has 100 squares" do
    expect(board.squares.length).to eq 100
  end

  it "has squares A1 to J10" do
    expect(board.squares.first.x).to eq "A"
    expect(board.squares.first.y).to eq 1

    expect(board.squares.last.x).to eq "J"
    expect(board.squares.last.y).to eq 10
  end

  it "has five ships" do
    expect(board.ships.length).to eq 5
  end

  it "has a carrier, battleship, submarine, destroyer, and patrol_boat" do
    ship_names = board.ships.map(&:name)

    %w(carrier battleship submarine destroyer patrol_boat).each do |name|
      expect(ship_names).to include name
    end
  end
end
