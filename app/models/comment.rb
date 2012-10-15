class Comment < ActiveRecord::Base
   attr_accessible :content
  validates_presence_of :content
  validates_presence_of :Post_id
  validates_presence_of :User_id
  validates_length_of :content, {:minimum => 10}
  belongs_to :post
  belongs_to :user
  has_many  :c_votes, :dependent => :destroy
end
