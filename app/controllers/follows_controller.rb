# frozen_string_literal: true

# Follows controller
class FollowsController < ApplicationController

  def create
    following_id = params[:following]
    following_user = User.find_by(id: following_id)

    if following_user && !current_user.follows?(following_user)
      current_user.following_records.create(following: following_user).inspect
    end
  
    render turbo_stream: turbo_stream.replace(
             following_user, partial: 'follows/follow', locals: { following_user: following_user }
           )
  end

  def destroy
    following_id = params[:id]
    following_user = User.find_by(id: following_id)

    if following_user && current_user.follows?(following_user)
      current_user.following_records.find_by(following: following_user).destroy
    end
    
    render turbo_stream: turbo_stream.replace(
             following_user, partial: 'follows/follow', locals: { following_user: following_user }
           )
  end
  
end
