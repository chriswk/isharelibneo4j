require 'fileutils'
namespace :db do
  desc "Deletes the database for #{:environment}"
  task :drop => :environment do
    databasefolder = File.join(Rails.root, "db", "neo4j-#{Rails.env}")
    if File.directory?(databasefolder)
      puts "Deleting #{databasefolder}"
      FileUtils.rm_rf databasefolder
    end
  end
end