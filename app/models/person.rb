class Person < Neo4j::Rails::Model
  property :name, :type => String
  property :birth_date, :type => Date
  property :tmdb_id, :index => :exact, :unique => :true
  property :tmdb_url, :index => :exact, :unique => :true
  property :imdb_url, :index => :exact, :unique => :true
  has_n(:acted_in).to(Movie).relationship(Role)
end
