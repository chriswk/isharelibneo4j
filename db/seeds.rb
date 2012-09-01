[603, 24428, 15268].each do |movie_id|
  m = Movie.find_or_create_by(:tmdb_id => movie_id)
  m.update_from_tmdb
end
