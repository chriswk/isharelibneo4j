class Provider < Neo4j::Rails::Model
  property :name, :index => :exact
  property :uid, :index => :exact, :unique => true
  has_one(:user).from(User, :provider)
end
