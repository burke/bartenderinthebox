class Drink < ActiveRecord::Base
  has_many :recipe_items
  has_many :ingredients, :through => :recipe_items

  def available?
    inventory = Reservoir.find(:all).map{|r|r.ingredient_id}
    (ingredients.map{|r|r.id} - inventory) == []
    # ingredients.all?{|i| i.available?}
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
    $log.info "Starting mixing of D##{id} (#{name})"
    threads = []
    recipe_items.each do |r_item|
      threads << Thread.new do
        reservoir = Reservoir.find_by_ingredient_id(r_item.ingredient_id)
        $log.debug "Activating Reservoir R##{reservoir.bay} for #{r_item.quantity} mL of I##{r_item.ingredient_id}."
        reservoir.dispense( r_item.quantity )
        $log.debug "Finished dispensing I##{r_item.ingredient_id}"
      end
    end
    threads.each{ |t| t.join }
    $log.info "Finished mixing D##{id} (#{name})"
  end


end
