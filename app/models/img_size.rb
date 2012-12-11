class ImgSize < Neo4j::Rails::Model
  property :name
  property :url, :index => :exact, :unique => true
  has_one(:poster).from(Poster, :sizes)
end