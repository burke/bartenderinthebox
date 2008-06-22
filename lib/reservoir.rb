class Reservoir

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
    self.open
    sleep( 0.06 * ml )
    self.close
  end

  private #################
  def open
    # do something eventually...
  end

  def close
    # do something eventually...
  end
  
end
