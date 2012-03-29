class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :fb_uid

    has_one :facebook_account
    has_many :facebook_node
    has_many :friends, :through => :facebook_node, :foreign_key => :facebook_account_id, :source=>:facebook_account

end
