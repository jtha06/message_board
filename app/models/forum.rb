class Forum < ActiveRecord::Base
  attr_accessible :name, :description
  has_many :topics, :dependent => :destroy  
  belongs_to :users
  accepts_nested_attributes_for :topics
  
  def most_recent_post  
    topic = Topic.first(:order => 'last_post_at DESC', :conditions => ['forum_id = ?', self.id])  
    return topic  
  end  
end
