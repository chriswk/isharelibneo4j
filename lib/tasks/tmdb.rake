namespace :tmdb do
  desc "Accepts an API key and desired language on the command line and creates an initializer to setup the ruby-tmdb gem"
  task :setup, :apiKey, :lang do |t, args|
    apiKey = args[:apiKey] ||= "REPLACEWITHYOURAPIKEY"
    lang = args[:lang] ||= "en"
    initializerFile = "config/initializers/tmdb.rb"
    
    puts "Apikey set to '#{apiKey}'"
    puts "Language set to '#{lang}'"
    create_initializer(apiKey, lang, initializerFile)
    puts "Wrote #{initializerFile}"
  end
  
  def create_initializer(apiKey, lang, initializerFile)
    tmdbSetup = <<-eos
    require 'rubygems'
    require 'ruby-tmdb'
    Tmdb.api_key = "#{apiKey}"
    Tmdb.default_language = "#{lang}"
    eos
    
    File.open(initializerFile, 'w') {|f| f.puts(tmdbSetup)}
  end
end