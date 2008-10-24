# Maintains the state of a physical reservoir.
class Reservoir

  attr_reader :bay, :contents

  def initialize( bay, contents )
    @bay      = bay
    @contents = contents
  end

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
