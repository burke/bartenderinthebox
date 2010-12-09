class RecipeItem < ActiveRecord::Base
  belongs_to :drink
  belongs_to :ingredient

  def dispense
    Reservoir.
      where(:ingredient_id => r_item.ingredient).
      first.
      dispense(r_item.quantity)
  end 
 
end
