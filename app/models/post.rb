class Post < ActiveRecord::Base
  attr_accessible :content, :title, :Category_id
  validates_presence_of :content
  validates_presence_of :title
  validates_presence_of :User_id
  validates_presence_of :Category_id

  has_many :comments, :dependent => :destroy
  has_many :p_votes, :dependent => :destroy
end
