class Drink < ActiveRecord::Base

  CACHE_FILE = "#{RAILS_ROOT}/tmp/availability_cache.marshal"
  
  has_many :recipe_items
  has_many :ingredients, :through => :recipe_items

  def self.find_all_available
    self.expire_availability_cache if !File.exists? CACHE_FILE

    require 'ingredient'
    require 'recipe_item'
    Marshal.load(File.read(CACHE_FILE))
  end

  def self.expire_availability_cache
    File.open(CACHE_FILE,'w') do |f|
      f.puts Marshal.dump(Drink.find(:all).select{|d|d.available?})
    end
  end
  
  def mix
    for ingredient in ingredients
      ingredient.dispense(30)
    end
  end

  def available?
    ! ingredients.map{|i|i.available?}.include?(false)
  end

end
