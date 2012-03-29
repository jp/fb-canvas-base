class FacebookNode < ActiveRecord::Base
  belongs_to :user
  belongs_to :facebook_account
end
