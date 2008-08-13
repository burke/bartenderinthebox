class RecipeItem < ActiveRecord::Base
  belongs_to :drink
  belongs_to :ingredient
end
