# name

class Drink < ActiveRecord::Base
  has_many :recipe_items
  has_many :ingredients, :through => :recipe_items

  def available?
    inventory = Reservoir.find(:all).map{|r|r.ingredient_id}
    (ingredients.map{|r|r.id} - inventory) == []
    # ingredients.all?{|i| i.available?}
  end

  def self.find_available
    inventory = Reservoir.find(:all).map{|r|r.ingredient_id}

    Drink.find(:all).select do |drink|
      (drink.ingredients.map{|r|r.id} - inventory) == []
    end
  end

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
