# name

class Drink < ActiveRecord::Base
  has_many :recipe_items
  has_many :ingredients, :through => :recipe_items

  def available?
    ingredients.all?{|i| i.available?}
  end

  def self.find_available
    inventory = Reservoir.find(:all).map{|r|r.ingredient_id}

    Drink.find(:all).select do |drink|
      (drink.ingredients.map{|i|i.id} - inventory) == []
    end
  end

end
