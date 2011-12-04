class Topic < ActiveRecord::Base
  attr_accessible :name, :last_poster_id, :last_post_at, :user_id, :forum_id
  belongs_to :forum, :inverse_of => :topics
  belongs_to :user  
  has_many :posts, :dependent => :destroy
accepts_nested_attributes_for :posts  
end
