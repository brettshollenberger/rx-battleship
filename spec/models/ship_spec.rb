require "spec_helper"

describe Ship do
  let(:board) { FactoryGirl.create(:board) }
  let(:ship)  { board.ships.first }

  it "references its board" do
    expect(ship.board).to eq board
  end
end
