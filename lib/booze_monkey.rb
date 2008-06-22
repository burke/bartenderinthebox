
require File.dirname(__FILE__)+'/reservoir'

require 'rubygems'
require 'yaml'

# The BoozeMonkey handles monitoring of reservoirs, and the mapping of ingredients to reservoirs.
# BartenderInTheBox tells the BoozeMonkey it wants 30mL of vodka, and BoozeMonkey
# activates the appropriate reservoir for the appropriate amount of time.
class BoozeMonkey

  def initialize
    @reservoirs = YAML.load(File.open( File.dirname(__FILE__)+'/../data/reservoirs.yml' ))
  end

  def reservoir_by_contents( contents )
    @reservoirs.select{ |res| res.contents == contents }.first
  end

  def reservoir_by_bay( bay )
    @reservoirs.select{ |res| res.bay == bay }.first
  end
  
  def dispense( id, quantity )
    reservoir = reservoir_by_contents( id )
    puts "Activating Reservoir ##{reservoir.bay} for #{quantity} mL of #{reservoir.contents}."
    reservoir.dispense( quantity )
  end
    
end

if __FILE__ == $0
  boozemonkey = BoozeMonkey.new
  boozemonkey.dispense( 21, 30 )
end
