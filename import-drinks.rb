require 'sqlite3'
require 'yaml'

db = SQLite3::Database.new( "db/production.sqlite3" )

iy = YAML.load(File.open('initial/data/drinks.yml'))

iy.each do |k,v|
  #db.execute( "insert into drinks values ( ?, ?, ? )", k, v[:name], v[:percentage].to_i)
end
