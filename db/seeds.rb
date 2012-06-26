# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Emanuel', :city => cities.first)
vampire = Movie.create(:title => "Vampire", :year => 2011)
ecstacy = Movie.create(:title => "Ecstacy", :year => 2012)
space_milkshake = Movie.create(:title => "Space Milkshake", :year => 2012)
sf = Movie.create(:title => "Street Fighter : The Legend of Chun-Li", :year => 2009)
earthsea = Movie.create(:title => "Earthsea", :year => 2004)

kristin = Person.create(:name => "Kristin Kreuk", :birth_date => Date.parse("1982-12-30"))

[vampire,ecstacy,space_milkshake,sf,earthsea].each do |movie|
  kristin.acted_in << movie
end
kristin.acted_in_rels.to_a do |role|
  case role
    when role.end_node == ecstacy
      role.character = "Heather"
    when role.end_node == space_milkshake
      role.character == "Tilda"
    when role.end_node == sf
      role.character == "Chun-Li"
    when role.end_node == earthsea
      role.character = "Tirzah"
    else
      puts "No known role for #{role.end_node}"
  end
  role.save
end


matrix1 = Movie.new(:title => "The Matrix", :year => 1999)
matrix2 = Movie.new(:title => "The Matrix Reloaded", :year => 2003)
matrix3 = Movie.new(:title => "The Matrix Revolutions", :year => 2003)
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
