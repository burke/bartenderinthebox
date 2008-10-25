#!/usr/bin/env ruby

begin
  require 'rubygems'
rescue LoadError
end
require 'sqlite3'
require 'yaml'

DATA_PATH = File.join(File.dirname(__FILE__),'/..')

db = SQLite3::Database.new( File.join(DATA_PATH,'/btb.sqlite3') )
drinks = YAML.load(File.open(File.join(DATA_PATH,'/drinks.yml')))

drinks.each do |drink_id, drink_data|
  db.execute( "insert into drinks ( id, name ) values ( ?, ? )", drink_id, drink_data[:name])
  v[:ingredients].each do |ingredient_id, ingredient_quantity|
    db.execute( "insert into recipe_items ( drink_id, ingredient_id, quantity ) values ( ?, ?, ? )", drink_id, ingredient_id, ingredient_quantity)
  end rescue nil
end
