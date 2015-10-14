require 'twilio-ruby' 

class DashboardController <  GroupBaseController
  include ApplicationHelper
  include DiscussionIndexCacheHelper
  after_filter :clear_discussion_index_caches, only: :show

 
# put your own credentials here 
account_sid = 'AC956d8ea1d2c87b6f18c2533f4f260394' 
auth_token = 'c278a7dbeb79a51e7dd1a70717b5de9d' 
 
# set up a client to talk to the Twilio REST API 
@client = Twilio::REST::Client.new account_sid, auth_token 
 
@client.account.messages.create({
  :from => '+15012420926', 
  :to => '858-382-7768', 
  :body => 'wasup',  
})

  def show
    @discussions = Queries::VisibleDiscussions.new(groups: current_user.groups, user: current_user).not_muted

    if sifting_unread?
      @discussions = @discussions.unread
    end

    @discussions = @discussions.joined_to_current_motion.
                                preload(:current_motion, {group: :parent}).
                                order_by_closing_soon_then_latest_activity.
                                page(params[:page]).per(20)
    build_discussion_index_caches

    # on discussion, preload author, current_motion -> author, votes
    # load discussion_readers for discussion, user and store in a hash key: discussion_id
    # preload motion_readers for user, discussions -> current_motions
  end
end
