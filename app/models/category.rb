class Category < ActiveRecord::Base
  attr_accessible :name ,:description
  validates_presence_of :name
  validates_length_of :name, {:minimum=>3}

end
