class Board < ActiveRecord::Base
  has_many :squares
  after_create :create_squares

private
  def create_squares
    x_values.each do |x|
      y_values.each do |y|
        squares.create(x: x, y: y)
      end
    end
  end

  def x_values
    ("A".."J").to_a
  end

  def y_values
    (1..10).to_a
  end
end
