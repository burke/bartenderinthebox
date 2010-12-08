class Drink < ActiveRecord::Base
  has_many :recipe_items
  has_many :ingredients, :through => :recipe_items

  def available?
    ingredients.all?(&:available?)
  end

  scope :available, where(<<-SQL)
  id IN (

    -- All the drinks that have at least one ingredient present
    SELECT d FROM (
      SELECT DISTINCT drinks.id AS d
      FROM drinks 
      INNER JOIN recipe_items ON drinks.id = recipe_items.drink_id 
      LEFT OUTER JOIN reservoirs ON recipe_items.ingredient_id = reservoirs.ingredient_id
      WHERE reservoirs.id NOT NULL
    )

    EXCEPT 

      -- All thr drinks that have at least one ingredient missing.
      SELECT d2 FROM (
        SELECT DISTINCT drinks.id AS d2
        FROM drinks 
        INNER JOIN recipe_items ON drinks.id = recipe_items.drink_id 
        LEFT OUTER JOIN reservoirs ON recipe_items.ingredient_id = reservoirs.ingredient_id
        WHERE reservoirs.id IS NULL
      )
    )
  
  SQL

  def mix
    recipe_items.map do |r_item|
      Thread.new { 
        Reservoir.
          find_by_ingredient_id(r_item.ingredient_id).
          dispense( r_item.quantity )
      }
    end.map(&:join)
  end


end
