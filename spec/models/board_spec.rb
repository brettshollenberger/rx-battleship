require "spec_helper"

describe Board do
  let(:board)  { FactoryGirl.create(:board) }
  let(:board2) { FactoryGirl.create(:board) }

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

  it "knows when two squares are vertically contiguous" do
    first, second = board.squares.first, board.squares.second

    expect(board.squares.contiguous?(first, second)).to be true
  end

  it "knows when two squares are not vertically contiguous" do
    first, third = board.squares.first, board.squares.third

    expect(board.squares.contiguous?(first, third)).to be false
  end

  it "knows when five squares are vertically contiguous" do
    expect(board.squares.contiguous?(board.squares[0..4])).to be true
  end

  it "knows when any number of squares are vertically contiguous" do
    expect(board.squares.contiguous?(board.squares.column("A"))).to be true
  end

  it "knows when two squares are horizontally contiguous" do
    first, eleventh = board.squares.first, board.squares[10]

    expect(board.squares.contiguous?(first, eleventh)).to be true
  end

  it "knows when two squares are not horizontally contiguous" do
    first, twenty_first = board.squares.first, board.squares[20]

    expect(board.squares.contiguous?(first, twenty_first)).to be false
  end

  it "knows when any number of squares is horizontally contiguous" do
    expect(board.squares.contiguous?(board.squares.row(1))).to be true
  end

  it "loads squares at a particular location" do
    expect(board.squares.at(x: "A", y: 1)).to eq board.squares.first
  end

  it "allows a ship to be set in an empty set of contiguous squares the len of the ship" do
    sq1 = board.squares.at(x: "A", y: 1)
    sq2 = board.squares.at(x: "A", y: 2)
    sq3 = board.squares.at(x: "A", y: 3)

    submarine = board.ships.where(name: "submarine").first

    expect(board.squares.settable?(submarine, sq1, sq2, sq3)).to be true
  end

  it "does not allow a ship at any taken squares" do
    sq1 = board.squares.at(x: "A", y: 1)
    sq2 = board.squares.at(x: "A", y: 2)
    sq3 = board.squares.at(x: "A", y: 3)

    submarine = board.ships.where(name: "submarine").first
    destroyer = board.ships.where(name: "destroyer").first

    board.squares.set(submarine, sq1, sq2, sq3)

    expect(board.squares.settable?(destroyer, sq1, sq2, sq3)).to be false
  end

  it "does not allow a ship to be set at non-contiguous squares" do
    sq1 = board.squares.at(x: "A", y: 1)
    sq2 = board.squares.at(x: "A", y: 2)
    sq4 = board.squares.at(x: "A", y: 4)

    submarine = board.ships.where(name: "submarine").first

    expect(board.squares.settable?(submarine, sq1, sq2, sq4)).to be false
  end

  it "does not allow a ship to be set at squares from different boards" do
    sq1 = board.squares.at(x: "A", y: 1)
    sq2 = board.squares.at(x: "A", y: 2)
    sq3 = board2.squares.at(x: "A", y: 3)

    submarine = board.ships.where(name: "submarine").first

    expect(board.squares.settable?(submarine, sq1, sq2, sq3)).to be false
  end
end
