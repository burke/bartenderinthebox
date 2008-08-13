class Reservoir < ActiveRecord::Base

  has_one :ingredient
  
  def dispense( ml )
    # Dispense fluid...
  end

  def after_save
    Drink.expire_availability_cache
  end
  
end
