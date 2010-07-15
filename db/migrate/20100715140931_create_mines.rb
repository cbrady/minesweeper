class CreateMines < ActiveRecord::Migration
  def self.up
    create_table :mines do |t|
      t.integer :game_id
      t.integer :x
      t.integer :y

      t.timestamps
    end
  end

  def self.down
    drop_table :mines
  end
end
