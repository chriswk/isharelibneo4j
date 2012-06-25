class Movie < Neo4j::Rails::Model
  property :title, :type => String
  property :release_year, :type => Fixnum

end
