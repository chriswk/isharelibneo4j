class Size < Neo4j::Rails::Model
  property :name, :index => :exact, :unique => true
  property :url
  has_one(:poster).from(Poster, :sizes)
  def map_from_tmdb(name, size)
    self.name = name
    self.url = size.url
  end
end