class Role < Neo4j::Rails::Relationship
  property :title, :character, :index => :exact
  property :department, :index => :exact
  property :job
  # To change this template use File | Settings | File Templates.
end