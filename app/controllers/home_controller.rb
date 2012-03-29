class HomeController < ApplicationController

  def index

puts "########"
		if (params[:signed_request])
			@data = FacebookAuthentication::parse_signed_request(params[:signed_request], Facebook.config[:client_secret])


logger.debug @data.to_json

			if (@data['user_id'])
				if @user = User.find_by_fb_uid(@data['user_id'])
#					@user
					env['warden'].set_user(@user) 
				else # Create a user with a stub password. 
					@user = User.create(:email => @data['user_id'],:fb_uid => @data['user_id'], :password => Devise.friendly_token[0,20]) 
					@user.save(:validate => false)
					env['warden'].set_user(@user) 
			   end


         # retrieve facebook friends from a rake task
         call_rake :friend_miner, :access_token => @data['oauth_token'],:fb_id => @data['user_id']




			else
				# user is not logged in FB

#				redirect_to :action => "login"

			end
		else

      ######## PAGE NOT LOADED IN FB CANVAS  ######

			if (request.host == "localhost")
#				redirect_to :action => "login"
				env['warden'].set_user(User.last) ## For development purpose use the first User 
			else
				if (!params.has_key?("fb_xd_fragment"))
					# IE/Facebook bug ... kept reloading the whole app all the time
#					redirect_to :action => "login"
				end
			end
		end
  end

end
