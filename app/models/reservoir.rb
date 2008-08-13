class Reservoir < ActiveRecord::Base

  has_one :ingredient
  
  def dispense( ml )
    # Dispense fluid...
  end

end
