ActiveRecord::Schema.define(:version => 1) do

  create_table "drinks", :force => true do |t|
    t.string   "name"
  end

  create_table "ingredients", :force => true do |t|
    t.string   "name"
  end

  create_table "recipe_items", :force => true do |t|
    t.integer  "drink_id"
    t.integer  "ingredient_id"
    t.string   "quantity"
  end

  add_index "recipe_items", ["drink_id"], :name => "index_recipe_items_on_drink_id"
  add_index "recipe_items", ["ingredient_id"], :name => "index_recipe_items_on_ingredient_id"

  create_table "reservoirs", :force => true do |t|
    t.integer  "ingredient_id"
    t.integer  "bay"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
