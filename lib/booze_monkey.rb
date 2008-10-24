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

  def dispense( ingredients )
    threads = []
    ingredients.each do |id, quantity|
      threads << Thread.new do
        reservoir = reservoir_by_contents( id )
        $log.debug "Activating Reservoir ##{reservoir.bay} for #{quantity} mL of #{reservoir.contents}."
        reservoir.dispense( quantity )
        $log.debug "Finished dispensing #{reservoir.contents}"
      end
    end
    threads.map{ |t| t.join }
  end

  def inventory
    ingredients = @reservoirs.map{ |res| res.contents }
    return ingredients
  end

  def inventory_a
    @reservoirs.map do |res|
      {res.bay => {
        :contents_id => res.contents,
        :contents_name => INGREDIENTS[res.contents][:name] }}
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
