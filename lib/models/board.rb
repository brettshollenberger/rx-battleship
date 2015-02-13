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
    Board.x_values.each do |x|
      Board.y_values.each do |y|
        squares.create(x: x, y: y)
      end
    end
  end

  def create_ships
    Ship.names.each do |name|
      ships.create(name: name)
    end
  end
end
