# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
connection = ActiveRecord::Base.connection
sql = File.read('db/cities_fr.sql')
statements = sql.split(/;$/)
statements.pop  # the last empty statement

ActiveRecord::Base.transaction do
  statements.each do |statement|
    connection.execute(statement)
  end
end
