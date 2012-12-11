class Poster < Neo4j::Rails::Model
  has_n(:sizes).to(Size)
  property :width
  property :height
  property :iso_639_1
  property :file_path, :unique => true, :index => :exact
  has_one(:movie).to(Movie, :posters)
  def map_tmdb(poster)
    self.width = poster.width
    self.height = poster.height
    self.iso_639_1 = poster.iso_639_1
    self.file_path = poster.file_path
    poster.sizes.map(Size)
  end
end