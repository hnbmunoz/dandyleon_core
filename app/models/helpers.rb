class Helpers
  def self.generate_token
    return (0...50).map { ('a'..'z').to_a[rand(26)] }.join 
  end  

  def self.valid_token?(token)
    return User.find_by(:authorization_token => token) != nil 
  end
end