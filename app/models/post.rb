class Post < ActiveRecord::Base
  attr_accessible :content
  belongs_to :topic, :inverse_of => :posts
  belongs_to :user
end
