# frozen_string_literal: true

# Follows controller
class FollowsController < ApplicationController

  def unfolloweds
    @user_suggestions.page_number = params[:page].present? ? params[:page].to_i : 1

    render turbo_stream: 
      turbo_stream.append(:modal_users_suggestions_list,
        partial: 'follows/modal-users-suggestions-list',
        locals: { firsts_to_follow: @user_suggestions.firsts_to_follow }
      )
  end

  def create
    # getting the following user
    following_id = params[:id]
    following_user = User.find_by(id: following_id)

    # create a follow relationship
    current_user.create_follow(following_user);

    # render and replace all follow buttons and counters
    render turbo_stream: [
      # follow button on user view
      turbo_stream.replace(
        "follow_button_#{following_id}", 
        partial: 'components/follow-button', 
        locals: { 
          user: following_user,
          size: "md"
        }
      ),
      # follow counters on user view
      turbo_stream.replace(
        "follow_counters_#{following_id}", 
        partial: 'devise/registrations/components/follow-counters', 
        locals: { user: following_user }
      ),
      # follow option on post component
      turbo_stream.replace(
        "follow_post_option_#{following_id}", 
        partial: 'follows/follow', 
        locals: { following_user: following_user }
      ),
    ]
  end

  def destroy
    # getting the following user
    following_id = params[:id]
    following_user = User.find_by(id: following_id)

    # destroy a follow relationship
    current_user.destroy_follow(following_user);
    
    # render and replace all follow buttons and counters
    render turbo_stream: [
      # follow button on user view
      turbo_stream.replace(
        "follow_button_#{following_id}", 
        partial: 'components/follow-button', 
        locals: { 
          user: following_user,
          size: "md"
        }
      ),
      # follow counters on user view
      turbo_stream.replace(
        "follow_counters_#{following_id}", 
        partial: 'devise/registrations/components/follow-counters', 
        locals: { user: following_user }
      ),
      # follow option on post component
      turbo_stream.replace(
        "follow_post_option_#{following_id}", 
        partial: 'follows/follow', 
        locals: { following_user: following_user }
      ),
    ]

  end
  
end
