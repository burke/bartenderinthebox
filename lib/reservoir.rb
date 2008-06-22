# Maintains the state of a physical reservoir.
class Reservoir

  attr_reader :bay, :contents, :level
  
  def initialize( bay, contents )
    @bay      = bay
    @contents = contents
    update_level
  end

  def update_level
    # @level = << Code to read pressure sensor in tank >>
    @level = 375
  end

  def dispense( ml )
    open
    sleep( 0.06 * ml )
    close
  end

  private #################
  def open
    # do something eventually...
  end

  def close
    # do something eventually...
  end
  
end
