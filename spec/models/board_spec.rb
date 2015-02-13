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

  it "caches squares" do
    expect(board.squares.cached)
  end
end
