class CreateRecipeItems < ActiveRecord::Migration
  def self.up
    create_table :recipe_items do |t|
      t.integer :drink_id
      t.integer :ingredient_id
      t.string  :quantity
      t.timestamps
    end
  end

  def self.down
    drop_table :recipe_items
  end
end
