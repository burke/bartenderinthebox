class Ingredient < ActiveRecord::Base

  has_many :recipe_items
  has_many :drinks, :through => :recipe_items
  
  def available?
    Reservoir.find_by_ingredient_id(self.id) ? true : false
  end

  def dispense(ml)
    Reservoir.find_by_ingredient_id(self.id).dispense(ml)
  end
  
end
