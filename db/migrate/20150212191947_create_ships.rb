class CreateShips < ActiveRecord::Migration
  def change
    create_table :ships do |t|
      t.integer :board_id, :null => false
      t.string :name, :null => false
      t.timestamps
    end
  end
end
