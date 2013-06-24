# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  email      :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class User < ActiveRecord::Base
  attr_accessible :email, :name, :password, :password_confirmation
  has_secure_password
  
  has_many :microposts, dependent: :destroy
  
  has_many :relationships, foreign_key: "follower_id", dependent: :destroy
  #Since destroying a user should also destroy that user’s relationships,
  # we’ve gone ahead and added dependent: :destroy to the association;
  has_many :followed_users, through: :relationships, source: :followed
  
  has_many :reverse_relationships, foreign_key: "followed_id",
                                   class_name:  "Relationship",
                                   dependent:   :destroy
  #we actually have to include the class name
  #otherwise Rails would look for a ReverseRelationship class, which doesn’t exist                                 
  has_many :followers, through: :reverse_relationships, source: :follower
  # we could actually omit the :source key, since Rails will singularize “followers”
  # and automatically look for the foreign key follower_id in this case
  
  before_save { |user| user.email = email.downcase }
#  before_save { email.downcase! } #alternate implementation  
  before_save :create_remember_token
  
  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 6 }                    
  validates :password_confirmation, presence: true
  after_validation { self.errors.messages.delete(:password_digest) }
  
  def feed
     Micropost.from_users_followed_by(self)
  end
  
  def following?(other_user)
    relationships.find_by_followed_id(other_user.id)
    # Whether to include the explicit self is largely a matter of taste.
  end

  def follow!(other_user)
    relationships.create!(followed_id: other_user.id)
  end
  
  def unfollow!(other_user)
    relationships.find_by_followed_id(other_user.id).destroy
  end
  
  private
    def create_remember_token
      self.remember_token = SecureRandom.urlsafe_base64
    end                  
end
