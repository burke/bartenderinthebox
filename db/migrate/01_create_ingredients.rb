class CreateIngredients < ActiveRecord::Migration
  def self.up
    create_table :ingredients do |t|
      t.string  'name'
      t.integer 'percentage'
    end
  end

  def self.down
    drop_table :ingredients
  end
end
