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

  describe "#state" do
    it "is empty when no ship is set in it" do
      expect(square.state).to eq "empty"
    end

    it "is taken when set to a ship" do
      sq1 = board.squares.first
      sq2 = board.squares.second
      patrol_boat = board.ships.where(name: "patrol_boat").first

      board.squares.set(patrol_boat, sq1, sq2)

      expect(sq1.state).to eq "taken"
    end

    it "is hit when taken & guessed" do
      sq1 = board.squares.first
      sq2 = board.squares.second
      patrol_boat = board.ships.where(name: "patrol_boat").first

      board.squares.set(patrol_boat, sq1, sq2)
      sq1.guess

      expect(sq1.state).to eq "hit"
    end

    it "is miss when not taken & guessed" do
      square.guess
      expect(square.state).to eq "miss"
    end
  end
end
