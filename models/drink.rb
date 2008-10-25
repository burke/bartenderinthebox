# name

class Drink < ActiveRecord::Base
  has_many :recipe_items
  has_many :ingredients, :through => :recipe_items

  def available?
    inventory = Reservoir.find(:all)
    (ingredients - inventory) == []
    # ingredients.all?{|i| i.available?}
  end

  def self.find_available
    inventory = Reservoir.find(:all)

    Drink.find(:all).select do |drink|
      (drink.ingredients - inventory) == []
    end
  end

end
