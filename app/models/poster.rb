class Poster < Neo4j::Rails::Model
  has_n(:sizes).to(ImgSize)
  property :file_path, :unique => true, :index => :exact
  has_one(:movie).to(Movie, :posters)
  def map_tmdb(poster)
    sizeArray = poster.sizes.methods.map do |method|
        method if method.match(/^w\d+$/) || method.match(/^original$/)
    end.compact.each do |size|
      s = ImgSize.find_or_create_by(:url => poster.sizes.send(size).url)
      s.name = size.to_s
      s.save
      puts "Saving size #{s.name} with url #{s.url} and id: #{s.id}"
      self.sizes << s unless self.sizes.find(s)
    end
    self.save
  end
end