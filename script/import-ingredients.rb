#!/usr/bin/env ruby

begin
  require 'rubygems'
rescue LoadError
end
require 'sqlite3'
require 'yaml'

DATA_PATH = File.join(File.dirname(__FILE__),'/../data')

database = SQLite3::Database.new( File.join(DATA_PATH,'/btb.sqlite3') )
ingredients = YAML.load(File.open(File.join(DATA_PATH,'/ingredients_id_to_name.yml')))

puts "Loaded data. Writing to DB."

database.transaction do |db|
  ingredients.each do |id,name|
    db.execute( "insert into ingredients ( id, name ) values ( ?, ? )", id, name)
  end
end
