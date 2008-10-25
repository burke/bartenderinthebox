#!/usr/bin/env ruby

DATA_PATH = File.join(File.dirname(__FILE__),'/..')

puts "Dropping old database..."
`rm #{File.join(DATA_PATH,'/btb.sqlite3')}`

puts "Loading Schema..."
require File.join(DATA_PATH,'/script/load_schema')

puts "Importing Ingredients..."
require File.join(DATA_PATH,'/script/import-ingredients')

puts "Importing Reservoir Contents..."
require File.join(DATA_PATH,'/script/import-sample-reservoirs')

puts "Importing Drinks..."
require File.join(DATA_PATH,'/script/import-drinks')

