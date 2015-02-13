require_relative "./concerns/squares_list"

class Board < ActiveRecord::Base
  has_many :squares do
    include ::SquaresList
  end

  has_many :ships
  after_create :create_squares, :create_ships

  class << self
    def x_values
      ("A".."J").to_a
    end

    def y_values
      (1..10).to_a
    end
  end

private
  def create_squares
    Square.mass_insert do
      Board.x_values.map do |x|
        Board.y_values.map do |y|
          {x: x, y: y, board_id: id}
        end
      end.flatten
    end
  end

  def create_ships
    Ship.mass_insert do
      Ship.names.map do |name|
        {name: name, board_id: id}
      end
    end
  end
end
