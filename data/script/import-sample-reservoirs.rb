#!/usr/bin/env ruby

begin
  require 'rubygems'
rescue LoadError
end
require 'sqlite3'
require 'yaml'

DATA_PATH = File.join(File.dirname(__FILE__),'/..')

database = SQLite3::Database.new( File.join(DATA_PATH,'/btb.sqlite3') )
reservoirs = {
  1 => 7,
  2 => 8,
  3 => 15,
  4 => 334,
  5 => 12,
  6 => 745,
  7 => 43,
  8 => 92,
  9 => 128,
  10 => 144,
  11 => 837,
  12 => 278
}

database.transaction do |db|
  reservoirs.each do |bay,ingredient|
    db.execute( "insert into reservoirs ( ingredient_id, bay ) values ( ?, ? )", ingredient, bay)
  end
end
