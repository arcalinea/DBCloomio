class DashboardController <  GroupBaseController
  include ApplicationHelper
  include DiscussionIndexCacheHelper

  after_filter :clear_discussion_index_caches, only: :show

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

  #amrita's contribution to the demographics graph page race by gender
  #Ben refactored it
  def user_data

    @users = User.all

    demographics_stats = @users.map { |user| { gender: user.gender, race: user.race, count: User.where(gender: user.gender, race: user.race).count } }.uniq!

    respond_to do |format|
      format.json { render :json => demographics_stats.to_json }
    end

  end

  def demographics
  end

end