class CVote < ActiveRecord::Base
  attr_accessible :User_id,:Comment_id
  validates_presence_of :User_id, :Comment_id
end
