class Drink < ActiveRecord::Base
  has_many :recipe_items
  has_many :ingredients, :through => :recipe_items

  def available?
    ingredients.all?(&:available?)
  end

  scope :available, where(<<-SQL)
  id IN (
    -- All the drinks that have at least one ingredient present
    SELECT DISTINCT d1.id
    FROM drinks d1
    INNER JOIN recipe_items ON d1.id = recipe_items.drink_id 
    LEFT JOIN reservoirs ON recipe_items.ingredient_id = reservoirs.ingredient_id
    WHERE reservoirs.id IS NOT NULL
    AND d1.id NOT IN (
      -- All the drinks that have at least one ingredient missing.
      SELECT DISTINCT d2.id
      FROM drinks d2
      INNER JOIN recipe_items ri2 ON d2.id = ri2.drink_id 
      LEFT JOIN reservoirs r2 ON ri2.ingredient_id = r2.ingredient_id
      WHERE r2.id IS NULL
    )
  )
  SQL

  def mix
    recipe_items.map { |recipe_item|
      Thread.new { recipe_item.dispense }
    }.map(&:join)
  end


end
