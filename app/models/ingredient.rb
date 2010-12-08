class Ingredient < ActiveRecord::Base
  has_many :recipe_items
  has_many :drinks, :through => :recipe_items

  def available?
    ! ! Reservoir.find_by_ingredient_id(self.id)
  end

end
