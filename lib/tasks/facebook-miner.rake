namespace :facebook do
  desc "friend miner"
  task :friend_miner => :environment do
    user = FbGraph::User.me("this should be a real access token").fetch
  end
end


desc "friend miner"
task :friend_miner => :environment do


#puts ENV['ACCESS_TOKEN']
#puts ENV['FB_ID']

      fb_account = FacebookAccount.find_or_create_by_fb_id(ENV['FB_ID'])
      graph_user = FbGraph::User.me(ENV['ACCESS_TOKEN']).fetch

      user = User.find_by_fb_uid(ENV['FB_ID'])

      user.email = graph_user.email
      user.first_name = graph_user.first_name
      user.last_name = graph_user.last_name
      user.access_token = graph_user.access_token
      user.save

      fb_account.name = graph_user.name
      fb_account.user = User.find_by_fb_uid('683618123')
      fb_account.save
      # for each friend of this user, create a FacebookAccount record and link it to the user
      graph_user.friends.each do |friend|
puts friend.name

        friend_account = FacebookAccount.find_or_create_by_fb_id(friend.identifier)
        friend_account.name = friend.name
        friend_account.save
        
        if !fb_account.user.friends.include?(friend_account)
          fb_node = FacebookNode.new
          fb_node.user = fb_account.user
          fb_node.facebook_account = friend_account
          fb_node.save
        end
      end

end




def get_response_with_redirect(result)
end

