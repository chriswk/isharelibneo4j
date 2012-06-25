class Role < Neo4j::Rails::Relationship
  property :title, :character, :index => :exact
  # To change this template use File | Settings | File Templates.
end