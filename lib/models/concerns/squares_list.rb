require "active_support/concern"

module SquaresList
  extend ActiveSupport::Concern

  def set(ship, *squares)
    squares.flatten!

    if settable?(ship, *squares)
      squares.each do |square|
        square.update(ship: ship)
      end
    end
  end

  # True/false ship can be set at squares
  def settable?(ship, *squares)
    squares.flatten!

    ship.length == squares.length &&
      squares.all?(&:empty?) &&
      contiguous?(squares)
  end

  def at(coordinates)
    row(coordinates[:y]).select do |square|
      square.x == coordinates[:x]
    end.first
  end

  def row(y)
    select do |square|
      square.y == y
    end
  end

  def column(x)
    select do |square|
      square.x == x
    end
  end

  # contiguous?(*squares)
  #
  # True if all input squares are contiguous, 
  # either horizontally or vertically
  #
  # Else false
  #
  #   A B C D E
  # 1 x x x x x # A1-E1 contiguous horizontally
  # 2           
  # 3 x         # A3-A5 contiguous vertically
  # 4 x         
  # 5 x   x     # A5, C5 not contiguous
  #
  # A1, A2             => true
  # A1, A2, A3, A4, A5 => true
  # A1, B1             => true
  # A1, B1, C1, D1, E1 => true
  #
  # A1, A3             => false
  # A1, C1             => false
  def contiguous?(*squares)
    squares.flatten!

    same_board?(*squares) &&
      (vertically_contiguous?(*squares) || horizontally_contiguous?(*squares))
  end

  #   A B C D E
  # 1 x         # A1-A3 contiguous vertically
  # 2 x         # A1-A3 contiguous vertically
  # 3 x         # A1-A3 contiguous vertically
  # 4
  # 5   x       # B5-B6 contiguous vertically
  # 6   x       # B5-B6 contiguous vertically
  # 7
  # 8     x     # C8 & C10 not contiguous vertically
  # 9
  # 10    x     # C8 & C10 not contiguous vertically
  #
  # A1, A2             => true
  # A1, A2, A3, A4, A5 => true
  # A1, A3             => false
  # A1, B1             => false
  def vertically_contiguous?(*squares)
    same_column?(*squares) && increasing_y?(*squares)
  end

  #   A B C D E
  # 1 x x x x x # contiguous horizontally 
  # 2
  # 3 x   x     # not contiguous horizontally
  #
  # A1, B1             => true
  # A1, B1, C1, D1, E1 => true
  # A1, C1             => false
  # A1, A2             => false
  #
  def horizontally_contiguous?(*squares)
    same_row?(*squares) && increasing_x?(*squares)
  end

  def same_row?(*squares)
    same_val?(*squares, :y)
  end

  def same_column?(*squares)
    same_val?(*squares, :x)
  end

  def same_board?(*squares)
    same_val?(*squares, :board_id)
  end

  # 1, 2, 3 => true
  # 1, 3, 2 => true
  # 1, 2, 4 => false
  def increasing_y?(*squares)
    increasing_val? squares.map(&:y)
  end

  # "A", "B", "C" => true
  # "A", "C", "B" => true
  # "A", "B", "D" => false
  def increasing_x?(*squares)
    increasing_val? letters_to_numbers(*squares.map(&:x))
  end

  def letters_to_numbers(*letters)
    letters.map do |letter|
      letter_to_number(letter)
    end
  end

  def letter_to_number(letter)
    letter_to_number_hash[letter]
  end

private
  def same_val?(*squares, val)
    squares.map(&val).uniq.length == 1
  end

  def increasing_val?(*vals)
    each_pair(vals.sort).inject(true) do |increasing, (prev, this)|
      increasing &= this == prev + 1
    end
  end

  def letter_to_number_hash
    @letter_to_number_hash ||= Hash[Board.x_values.zip(Board.y_values)]
  end

  def each_pair(*array, &block)
    array  = array.flatten
    result = []
    i      = 0
    j      = 1

    until j == array.length do
      result << [array[i], array[j]]
      i += 1
      j += 1
    end

    if block_given?
      result.each do |pair|
        yield pair
      end
    else
      result
    end
  end
end
