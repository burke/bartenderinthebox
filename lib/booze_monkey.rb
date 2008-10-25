# The BoozeMonkey handles monitoring of reservoirs, and the mapping of ingredients to reservoirs.
# BartenderInTheBox tells the BoozeMonkey it wants 30mL of vodka, and BoozeMonkey
# activates the appropriate reservoir for the appropriate time period.
class BoozeMonkey

  def initialize
    @reservoirs = YAML.load(File.open("#{BTB_ROOT}/data/reservoirs.yml"))
  end

  # Dispense ingredients, all at once.
  def dispense( ingredients )
    threads = []
    ingredients.each do |id, quantity|
      threads << Thread.new do
        reservoir = reservoir_by_contents( id )
        $log.debug "Activating Reservoir ##{reservoir.bay} for #{quantity} mL of I##{reservoir.contents}."
        reservoir.dispense( quantity )
        $log.debug "Finished dispensing I##{reservoir.contents}"
      end
    end
    threads.map{ |t| t.join }
  end

  def inventory
    @reservoirs.map{ |res| res.contents }
  end

  def reservoir_contents
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
