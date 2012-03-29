class UserController < ApplicationController
  before_filter :authenticate_user!

  def friends
    @friends = current_user.friends.where("facebook_accounts.user_id IS NOT NULL")
    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @friends }
    end

  end

end
