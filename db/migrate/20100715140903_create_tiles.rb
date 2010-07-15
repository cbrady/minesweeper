class CreateTiles < ActiveRecord::Migration
  def self.up
    create_table :tiles do |t|
      t.integer :game_id
      t.integer :x
      t.integer :y
      t.boolean :flagged, :default => false
      t.boolean :cleared, :default => false

      t.timestamps
    end
  end

  def self.down
    drop_table :tiles
  end
end
