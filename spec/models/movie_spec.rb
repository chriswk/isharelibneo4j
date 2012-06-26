require 'spec_helper'

describe Movie do
  before(:each) do
    @attrs = {
      :title => "Test Movie",
      :year => 1999,
      :imdb_id => "tt1706593",
      :tmdb_id => "15418-test"
    }
  end
  it "should create a new instance given valid attributes" do
    Movie.create!(@attrs)
  end
  
  it "should refuse a movie without a title" do
    Movie.new(@attrs.merge(:title => "")).should_not be_valid
  end
  
  it "should reject a movie with duplicate tmdb_id" do
    Movie.create!(@attrs)
    Movie.new(@attrs.merge(:imdb_id => "other")).should_not be_valid
  end
  
  it "should reject a movie with duplicate imdb_id" do
    Movie.create!(@attrs)
    Movie.new(@attrs.merge(:tmdb_id => "different")).should_not be_valid
  end
end
