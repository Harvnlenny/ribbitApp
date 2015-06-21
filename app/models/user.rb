class User < ActiveRecord::Base
  has_secure_password
  has_many :ribbits

  has_many :follower_relationships, classname: "Relationship", foreign_key: "followed_id"
  has_many :followed_relationships, classname: "Relationship", foreign_key: "follower_id"
  has_many :followers, through: :follower_relationships
  has_many :followeds, through: :followed_relationships

  def following? user
    self.followeds.include? user
  end
 
  def follow user
    Relationship.create follower_id: self.id, followed_id: user.id
  end

end
