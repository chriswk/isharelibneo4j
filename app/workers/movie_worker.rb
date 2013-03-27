class MovieWorker
  include SideKiq::Worker
  sidekiq_options queue: "high"

  def perform(tmdb_id)
    puts "Updating #{self}"
    movie = Movie.find_or_create_by(:tmdb_id => tmdb_id)
    tm_movie = TmdbMovie.find(:id => self.tmdb_id)
    movie.map_tmdb(tm_movie)
    puts "Updated to [#{self} - title: #{self.title} - tmdb_id #{self.tmdb_id}]"
    movie.save
    map_countries(movie, tm_movie.production_countries)
    map_cast(movie, tm_movie.cast)
    map_posters(movie, tm_movie.posters)
  end

  def map_countries(movie, prod_countries)
    prod_countries.each do |country|
      CountryWorker.perform_async(country)
    end
  end

  def map_cast(movie, cast)
    cast.each do |role|
      PersonRoleWorker.perform_async(movie, role)
    end
  end

  def map_posters(movie, posters)
    posters.each do |poster|
      PosterWorker.perform_async(movie, poster)
    end
  end
end