#!/usr/bin/env ruby

DATA_PATH = File.join(File.dirname(__FILE__),'/../data')

puts "Dropping old database..."
`rm #{File.join(DATA_PATH,'/btb.sqlite3')}`

puts "Loading Schema..."
require File.join(File.dirname(__FILE__),'/load_schema')

puts "Importing Ingredients..."
require File.join(File.dirname(__FILE__),'/import-ingredients')

puts "Importing Reservoir Contents..."
require File.join(File.dirname(__FILE__),'/import-sample-reservoirs')

puts "Importing Drinks..."
require File.join(File.dirname(__FILE__),'/import-drinks')

