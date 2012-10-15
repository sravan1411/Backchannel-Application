class User < ActiveRecord::Base
  attr_accessible :email,:name,:password, :password_confirmation,:stored_password,:isAdmin
  attr_accessor :password
  validates :name, :presence => true,
            :length => {:maximum => 50}
  validates :email, :presence => true,
            :length => {:minimum => 6, :maximum => 50},
            :format => {with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i, :message => "Email is not valid."},
            :uniqueness => {:case_sensitive => false}
  validates :password, :presence => true,
            :length => {:within => 6..50},
            :confirmation => true
  before_save :store_password
  has_many :posts,:dependent => :destroy
  has_many :comments, :dependent => :destroy
  has_many :p_votes, :dependent => :destroy

  def store_password
    self.stored_password=password
  end


  def User.authenticate(userName,password)
    user=find_by_email(userName)
    if user
      if password==user.stored_password
        user
      end
    end

  end
end
