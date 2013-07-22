class Genre < Neo4j::Rails::Model
  property :name, :type => String
  property :tmdb_id, :index => :exact, :unique => true
end