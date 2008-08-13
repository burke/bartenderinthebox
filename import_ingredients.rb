require 'sqlite3'
require 'yaml'

db = SQLite3::Database.new( "db/development.sqlite3" )

iy = YAML.load(File.open('btb/data/ingredients.yml'))

iy.each do |k,v|
  db.execute( "insert into ingredients ( id, name, percentage ) values ( ?, ?, ? )", k, v[:name], v[:percentage].to_i)
end
