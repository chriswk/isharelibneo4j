[603, 24428, 15268, 91902, 14608].each do |movie_id|
  puts "Posting #{movie_id}"
  m = Movie.find_or_create_by(:tmdb_id => movie_id)
  Movie.update_from_tmdb
end
puts "Done updating"

