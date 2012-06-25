class Movie < Neo4j::Rails::Model
  property :title, :type => String, :index => :fulltext
  property :release_year, :type => Fixnum, :index => :exact
  property :tmdb_id, :type => Fixnum, :index => :exact, :unique => true
  property :tmdb_url, :index => :exact, :unique => true
  property :imdb_url, :index => :exact, :unique => true
  property :overview
  property :released, :type => Date
  has_n(:people).from(Person, :acted_in)
  has_n(:sequels)
  validates_presence_of :title

end
