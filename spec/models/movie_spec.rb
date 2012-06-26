require 'spec_helper'

describe Movie do
  it "allows to add a movie" do
    m = Movie.create{:title => "Matrix", :release_year => 1999}
    m.title.should eq("Matrix")
  end
  
  it "should retrieve a movie by title" do
    m = Movie.create{:title => "Matrix", :release_year => 1999}
    f = Movie.find(:first, :criteria => {:title => "Matrix"})
    f.should eq(m)
  end
end
