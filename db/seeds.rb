# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Emanuel', :city => cities.first)

matrix1 = Movie.new(:title => "The Matrix", :release_year => 1999)
matrix2 = Movie.new(:title => "The Matrix Reloaded", :release_year => 2003)
matrix3 = Movie.new(:title => "The Matrix Revolutions", :release_year => 2003)
matrix1.outgoing(:sequel) << matrix2
matrix2.outgoing(:sequel) << matrix3
matrix3.save
matrix2.save
matrix1.save
keanu = Person.new(:name => "Keanu Reeves", :birth_date => Date.parse('1964-09-02'))
carrie = Person.new(:name => "Carrie-Anne Moss", :birth_date => Date.parse("1967-08-21"))
laurence = Person.new(:name => "Laurence Fishburne", :birth_date => Date.parse("1961-07-30"))
hugo = Person.new(:name => "Hugo Weaving", :birth_date => Date.parse("1960-04-04"))

[keanu, carrie, laurence, hugo].each do |actor|
  [matrix1, matrix2, matrix3].each do |movie|
    actor.acted_in << movie
  end
  actor.save
end

keanu.acted_in_rels.each do |role|
  role.character = "Neo"
  role.save
end

carrie.acted_in_rels.each do |role|
  role.character = "Trinity"
  role.save
end

laurence.acted_in_rels.each do |role|
  role.character = "Morpheus"
  role.save
end

hugo.acted_in_rels.each do |role|
  role.character = "Agent Smith"
  role.save
end
