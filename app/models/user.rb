class User < Neo4j::Rails::Model
  property :nickname, :index => :exact, :unique => true
  property :name
  property :email, :index => :exact, :unique => true
  property :image, :type => String
  property :password
  property :birth_day, :type => Date
  has_n(:providers).to(Provider)

  def self.from_omniauth(auth)
    p = Provider.find_or_create_by(:uid => auth["uid"], :name => auth["provider"])
    if p.user != nil
      p.user
    else
      u = create_from_omniauth(auth)
    end
  end

  def self.create_from_omniauth(auth)
    p = Provider.find(:uid => auth["uid"], :name => auth["provider"])
    create! do |user|
        user.nickname = auth["info"]["nickname"]
        user.name = auth["info"]["name"]
        user.email = auth["info"]["email"]
        user.image = auth["info"]["image"]
        user.providers << p
      end
  end

end
