# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Category.delete_all
categories = ['dança', 'música', 'lazer', 'cultura', 'educação', 'teatro', 'cinema', 'festas', 'baladas', 'privado', 'aniversários', 'comemorações', 'congressos', 'cerimônias', 'recepções', 'convenções']

categories.each do |name|
  Category.create!(name: name)
end
