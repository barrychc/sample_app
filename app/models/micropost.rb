class Micropost < ActiveRecord::Base
  attr_accessible :content
  belongs_to :user
  
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }
  
  default_scope order: 'microposts.created_at DESC'
  def self.from_users_followed_by(user)
  followed_user_ids = "SELECT followed_id FROM relationships
                         WHERE follower_id = :user_id"
    where("user_id IN (#{followed_user_ids}) OR user_id = :user_id",
          user_id: user.id)
          
          
=begin  
      followed_user_ids = user.followed_user_ids
    where("user_id IN (?) OR user_id = ?", followed_user_ids, user)

Here the followed_user_ids method is synthesized by Active Record based on the
has_many :followed_users association (Listing 11.10); the result is that we
need only append _ids to the association name to get the ids corresponding to
the "user.followed_users" collection.	

user.followed_user_ids = user.followed_users.map(&:id)

the same method (e.g., to_s) gets called on each element, are common enough that
there’s a shorthand notation using an ampersand & and a symbol corresponding to the method
[1, 2, 3, 4].map { |i| i.to_s }
[1, 2, 3, 4].map(&:to_s)
=end
  end
end
=begin
For bigger sites, you would probably need to generate the feed asynchronously
using a background job. Such scaling subtleties are beyond the scope of this
tutorial, but the Scaling Rails screencasts are a good place to start.	
=end