class PosterWorker
  include Sidekiq::Worker

  def perform(movie, poster)
    p = Poster.find_or_create_by(:file_path => poster.file_path)
    p.map_tmdb(poster)
    p.save
    movie.posters << p
  end
end