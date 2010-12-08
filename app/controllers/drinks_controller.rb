class DrinksController < ApplicationController
  
  def index
    @drinks = Drink.available
  end 

  def mix
    @drink = Drink.find(params[:id])
    render :text => "MIXED #{@drink.name}!"
  end 
  
end 
