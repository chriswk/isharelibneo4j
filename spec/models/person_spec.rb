require 'spec_helper'

describe Person do
  before(:each) do
    @attrs = {
        :name => "Test person",
        :tmdb_id => 1,
        :imdb_id => 1
    }
  end

  it "should create a new instance from valid attributes" do
    Person.create!(@attrs)
  end

  it "should reject a person with no name" do
    noname = Person.new(@attrs.merge(:fullname => ""))
    noname.should_not be_valid
  end

  it "should reject a person with duplicate tmdb_id" do
    Person.create!(@attrs)
    Person.new(@attrs.merge(:imdb_id => "other")).should_not be_valid
  end

  it "should reject a person with duplicate imdb_id" do
    Person.create!(@attrs)
    Person.new(@attrs.merge(:tmdb_id => "different")).should_not be_valid
  end
end
