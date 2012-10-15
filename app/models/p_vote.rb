class PVote < ActiveRecord::Base
   attr_accessible :User_id,:Post_id
  validates_presence_of :User_id, :Post_id
end
