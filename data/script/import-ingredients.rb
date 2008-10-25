require 'sqlite3'
require 'yaml'

DATA_PATH = File.join(File.dirname(__FILE__),'/..')

db = SQLite3::Database.new( File.join(DATA_PATH,'/btb.sqlite3') )
ingredients = YAML.load(File.open(File.join(DATA_PATH,'/ingredients_id_to_name.yml')))

ingredients.each do |id,name|
  db.execute( "insert into ingredients ( id, name ) values ( ?, ? )", id, name)
end
