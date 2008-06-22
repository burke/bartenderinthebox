require "#{BTB_ROOT}/lib/reservoir"

require 'rubygems'
require 'yaml'

# The BoozeMonkey handles monitoring of reservoirs, and the mapping of ingredients to reservoirs.
# BartenderInTheBox tells the BoozeMonkey it wants 30mL of vodka, and BoozeMonkey
# activates the appropriate reservoir for the appropriate time period.
# We might need to take viscosity into account :/
class BoozeMonkey

  def initialize
    @reservoirs = YAML.load(File.open("#{BTB_ROOT}/data/reservoirs.yml"))
  end

  def dispense( id, quantity )
    reservoir = reservoir_by_contents( id )
    puts "Activating Reservoir ##{reservoir.bay} for #{quantity} mL of #{reservoir.contents}."
    reservoir.dispense( quantity )
  end

  def inventory
    ingredients = @reservoirs.map{ |res| res.contents }
    return ingredients
  end
  
  def show_fancy_inventory
    @reservoirs.each do |res|
      puts "Reservoir ##{res.bay}: #{res.level}mL of #{res.contents} (#{INGREDIENTS[res.contents][:name]})"
    end
  end

  private ###########################

  def reservoir_by_contents( contents )
    @reservoirs.select{ |res| res.contents == contents }.first
  end

  def reservoir_by_bay( bay )
    @reservoirs.select{ |res| res.bay == bay }.first
  end
  
end

if __FILE__ == $0 #############################
  boozemonkey = BoozeMonkey.new
  boozemonkey.dispense( 21, 30 )
end
