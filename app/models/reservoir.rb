class Reservoir < ActiveRecord::Base
  belongs_to :ingredient

  # Obviously this will change when there's actually hardware to control...
  def dispense( ml )
    begin
      start_pump
      sleep( 0.06 * ml )
    rescue
      # not much we can do here. Just make sure we shut off the pump.
    ensure
      stop_pump
    end
  end

  private #################
  def start_pump
    # do something eventually...
  end

  def stop_pump
    # do something eventually...
  end
end
