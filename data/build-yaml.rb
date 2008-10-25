#!/usr/bin/env ruby

begin
  require 'rubygems'
rescue LoadError
end
require 'yaml'
require 'libxml'
include LibXML

def to_float( str )
  str.sub!(/(\d+)\/(\d+)/) do |m|
    $1.to_f / $2.to_f
  end
  str.to_f
end

def to_ml( mamount, amount, measure )
  # Let's try relying _just_ on metric amount, hoping it's always set.
  case mamount
    when /^(.*) dl$/:                         # Decilitres
      return 100.0*to_float($1)
    when /^(.*) cl$/:                         # Centilitres
      return 10.0*to_float($1)
    when /^(.*) ml$/:                         # Millilitres
      return to_float($1)
    when /^(.*) dash(es)?$/:                  # Dashes
      return to_float($1)
    when /^(.*) splash(es)?$/:                # Splashes
      return 10.0*to_float($1)
    when /^(.*) drop(s)?$/:                   # Drops
      return to_float($1)
    when /^(.*) (lt?|liters?)$/:              # Litres
      return 1000.0*to_float($1)
    when /^(.*) (qt\.?)$/:                    # Quarts
      return 946.0*to_float($1)
    when /^(.*) (pints?)$/:                   # Pints
      return 473.0*to_float($1)
    when /^(.*) tbl?sp\.?$/:                  # Tablespoons
      return 15.0*to_float($1)
    when /^(.*) tsp\.?$/:                     # Teaspoons
      return 5.0*to_float($1)
    when /^(.*) (ounces?|oz\.?)$/:            # Ounces
      return 30.0*to_float($1)
    when /^(.*) (shot(s)?|jigger(s)?)$/:      # Shots
      return 45.0*to_float($1)
    when /^(.*) cups?$/:                      # Cups
      return 237.0*to_float($1)
  end

  return 0

end


CATEGORIES  = YAML.load(open('categories.yml'))
INGREDIENTS = YAML.load(open('ingredients_xml_to_ids.yml'))

doc = XML::Document.file('drinks.xml').root

drinks = { }
doc.find('Drink').each do |drink|
  ingredients = []

  ingred_format_fail = false

  drink.find('Ingredients/Ingredient').to_a.each do |ingredient|
    amount = to_ml(ingredient['MAmount'],ingredient['Amount'],ingredient['Measure'])
    if amount.zero?
      ingred_format_fail = true
    end
    ingredients << {
      :name    => INGREDIENTS[ingredient['Name'].strip],
      :amount  => amount
    }
  end

  category = CATEGORIES[drink.find('Categories/Category').to_a.first['Name']] rescue 2 # Unkown / Other

  next if ingred_format_fail # We're not going to put up with this shit.

  drink_id = drink['ID'].to_i

  drinks[drink_id] = {
    :ingredients => ingredients,
  # :id          => drink['ID'].to_i,
    :name        => drink['Name'].strip,
    :glass       => drink['Glass'].to_i,
  # :recipe      => drink['Recipe'].strip,
  # :garnish     => drink['Garnish'].strip,
    :category    => category
  }

end

puts "Finished parsing drinks. Generating YAML."

File.open('drinks.yml','w') do |file|
  file.puts YAML.dump(drinks)
end
