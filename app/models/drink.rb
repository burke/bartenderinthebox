class Drink < ActiveRecord::Base

  has_many :recipe_items
  has_many :ingredients, :through => :recipe_items
  
  def mix
    for ingredient in ingredients
      ingredient.dispense(30)
    end
  end

  def available?
    ! ingredients.map{|i|i.available?}.include?(false)
  end
  
end
