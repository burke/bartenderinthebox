# Because I can't think of the sane way to do this at 3:30am

module CLI_INTERFACE
  def self.run
    b = BartenderInTheBox.new

    puts "BartenderInTheBox initialized. Type 'h' for help."

    loop do
      case i = Readline::readline('btb> ')
      when /^m/i:
          b.mix(i.split(' ').last.to_i)
      when /^l/i:
          puts "== AVAILABLE DRINKS: ======="
        b.available_drinks.each do |drink|
          puts "#{drink.name} (#{drink.id}) : #{drink.ingredients}"
        end
      when /^r/i:
          puts "== RESERVOIR CONTENTS: ====="
        puts Reservoir.find(:all).inspect
      when /^[xq]/i, nil:
          exit(0)
      when /^\w/:
          puts "== AVAILABLE COMMANDS: ====="
        puts "  h: this menu"
        puts "  m <n>: Mix a drink"
        puts "  l: List available drinks"
        puts "  r: Show reservoir contents"
        puts "  x: Exit program"
      end
    end
  end
end
