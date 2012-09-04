class Country < Neo4j::Rails::Model
  property :iso_3166_1, :index => :exact, :unique => true
  property :name, :type => String
  index :name
  has_n(:movies).from(Movie, :countries)
end
