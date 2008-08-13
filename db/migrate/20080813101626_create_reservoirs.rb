class CreateReservoirs < ActiveRecord::Migration
  def self.up
    create_table :reservoirs do |t|
      t.integer :ingredient_id
      t.integer :bay
      t.timestamps
    end
  end

  def self.down
    drop_table :reservoirs
  end
end
