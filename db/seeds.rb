[603, 24428, 15268, 91902, 14608].each do |movie_id|
  puts "Posting #{movie_id}"
  MovieWorker.perform_async(movie_id)
end
puts "Done updating"
