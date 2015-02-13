class Board < ActiveRecord::Base
  has_many :squares
  has_many :ships
  after_create :create_squares, :create_ships

private
  def create_squares
    x_values.each do |x|
      y_values.each do |y|
        squares.create(x: x, y: y)
      end
    end
  end

  def create_ships
    Ship.names.each do |name|
      ships.create(name: name)
    end
  end

  def x_values
    ("A".."J").to_a
  end

  def y_values
    (1..10).to_a
  end
end
