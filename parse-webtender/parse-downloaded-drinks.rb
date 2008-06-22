#!/usr/bin/env ruby

require 'rubygems'
require 'hpricot'
require 'yaml'

class Parser

  # Conversions from most units to mL

  def initialize
  @conversions = {
      :oz => 30,
      :shot => 45,
      :tsp => 5,
      :teaspoon => 5,
      :tbsp => 15,
      :tablespoon => 15,
      :cup => 240,
      :pint => 473,
      :lb => 454,  # This is water. Things like butter will be different. 
      :tblsp => 15,
      :ml => 1,
      :cl => 10,
      :dl => 100,
      :l => 1000,
      :bottle => 750,
      :drop => 1,
      :dash => 1,
      :splash => 10
    }
    #ghetto pluralizer
    additions = {}
    @conversions.each do |k,v|
      str = k.to_s
      new_sym1 = (str + 'es').to_sym
      new_sym2 = (str + 's').to_sym
      additions.merge!({new_sym1 => v, new_sym2 => v})
    end
    @conversions.merge!(additions)
  end
  
  # Convert a string such as "1 1/2" to "1.5" (for example..)
  def frac_to_dec( s )
    s = s.gsub(/^\s+/,'').gsub(/\s+$/,'')
    
    if s.match(' ')
      a = s.split(' ')
      return frac_to_dec(a[0]) + frac_to_dec(a[1])
    elsif s.match('/')
      a = s.split('/')
      return Float(a[0].to_i)/(a[1].to_i)
    elsif s.match('-')
      a = s.split('-')
      return (a[0].to_i + a[1].to_i) / 2.0
    else return Float(s.to_i)
    end
  end

  # Convert a unit to a number of mL. Eg., "oz" => 30.0
  def unit_to_ml( s )
    unit = s.gsub(/^\s/,'').gsub(/\s.*$/,'').downcase.to_sym
    return 'fill' if unit.to_s.match(/fill/i)
    return 'parts' if unit.to_s.match(/part/i)
    return Float(@conversions[unit]) rescue 'units'
  end

  # Take a string such as "1 1/2 oz" and return the number of mL that entails.
  def millileterize( s )
    
    unitindex = s.index(/[^\d\s\/]/)
    number = s[0..unitindex-1] rescue "0"
    unit = s[unitindex..-1] rescue 'unit'
    n = frac_to_dec(number)
    u = unit_to_ml(unit.to_s)
    begin
      total = n*u
    rescue
      total = n.round.to_s + ' ' + u.to_s
    end
    return total
    
  end
  
  # Grab a drink from webtender, parse it like crazy, and return the data.
  def get_drink( i )
    url = "http://www.webtender.com/db/drink/#{i}"
    
    doc = Hpricot(open("download/#{i}.html"))
    
    drink = {}
    
    ingredients = (doc/"li").select{ |li| li.to_s.match '/db/ingred' }
    glass = ((doc/"td").select{ |td| td.to_s.match '/db/glass' }.first/"a").attr('href').split('/').last.to_i rescue "unspecified"
    name = (doc/"title").inner_html.gsub(' (The Webtender)','')
    
    
    drink[:ingredients] = {}
    drink[:glass] = glass
    drink[:name] = name
    
    for ingredient in ingredients
      a = ingredient/"a"
      code = a.attr('href').split('/').last.to_i
      quantity_raw = ingredient.inner_html.split('<').first.sub(/\s+$/,'')
      
      quantity_ml = millileterize( quantity_raw )
      
      drink[:ingredients].merge!({ code => quantity_ml })
    end

    return drink
  end
  
end

if __FILE__ == $0 ###################################################

  p = Parser.new

  drinks = {}

  for i in 1..6215
    puts "Parsing Drink ##{i}" if i%100 == 0
    drinks.merge!({i => p.get_drink(i)}) rescue puts "Drink ##{i} Not Found"
  end

  f=File.open('drinks.yml','w')
  f.puts YAML.dump(drinks)
  f.close
  
end
