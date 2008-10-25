# ingredient_id
# drink_id
# quantity

class RecipeItem < ActiveRecord::Base
  belongs_to :drink
  belongs_to :ingredient
end
