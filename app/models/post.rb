class Post < ActiveRecord::Base
  attr_accessible :content, :topic_id, :user_id, :likes
  belongs_to :topic, :inverse_of => :posts
  belongs_to :user
  
  def set_likes(num_likes)
    self.likes = num_likes
	save
  end	
  
  def like
    self.likes += 1
	save
  end

  def dislike
	self.likes -= 1
	save
  end	
end
