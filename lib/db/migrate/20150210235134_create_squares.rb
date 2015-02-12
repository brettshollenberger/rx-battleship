class CreateSquares < ActiveRecord::Migration
  def change
    create_table :squares do |t|
      t.string  :x, :null => false
      t.integer :y, :null => false
      t.integer :board_id, :null => false
      t.integer :ship_id 
      t.timestamps
    end
  end
end
