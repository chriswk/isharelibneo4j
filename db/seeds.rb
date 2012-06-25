# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Emanuel', :city => cities.first)

movies = Movie.create([{:title => "The Matrix", :release_year => 1999}, {:title => "The Matrix Revolutions", :release_year => 2003}, {:title => "The Matrix Reloaded", :release_year => 2003}])
actors = Person.create([{:name => "Keanu Reeves", :birth_date => Date.parse('1964-09-02')}, [:name => "Carrie-Anne Moss", :birth_date => Date.parse("1967-08-21")], [:name => "Laurence Fishburne", :birth_date => Date.parse("1961-07-30")], {:name => "Hugo Weaving", :birth_date => Date.parse("1960-04-04")}])
