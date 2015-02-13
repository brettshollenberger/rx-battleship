class AddGuessedToSquares < ActiveRecord::Migration
  def self.up
    add_column :squares, :guessed, :boolean, default: false
  end

  def self.down
    remove_column :squares, :guessed
  end
end
