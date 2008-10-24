require 'sqlite3'
require 'yaml'

db = SQLite3::Database.new( "db/development.sqlite3" )

iy = YAML.load(File.open('btb/data/drinks.yml'))

iy.each do |k,v|
  db.execute( "insert into drinks ( id, name ) values ( ?, ? )", k, v[:name])
  v[:ingredients].each do |ik, iv|
    db.execute( "insert into recipe_items ( drink_id, ingredient_id, quantity ) values ( ?, ?, ? )", k, ik, iv)
  end rescue nil
end
