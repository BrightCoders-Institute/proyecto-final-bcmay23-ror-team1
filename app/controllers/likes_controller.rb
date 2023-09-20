# frozen_string_literal: true

# Likes controller
class LikesController < ApplicationController
  before_action :set_post

  def create
    return if @post.liked_by?(current_user)
    @post.likes.create(user: current_user)
    render_updatables
  end

  def destroy
    return unless @post.liked_by?(current_user)
    @post.likes.find_by(user: current_user).destroy
    render_updatables
  end

  private 

  def render_updatables
    visible_reposts = @post.shared_posts_relation.where(user_id: @user_suggestions.follows_ids)

    updatable_frames = visible_reposts.map { |repost|
      action_prefix = "shared_post_#{repost.id}_by_user_#{repost.user.id}"
      turbo_stream.update("#{action_prefix}_like_button",
        partial: 'likes/like',
        locals: { post: @post, action_prefix: action_prefix }
      )
    }
    updatable_frames.append(
      turbo_stream.update("post_#{@post.id}_like_button",
        partial: 'likes/like',
        locals: { post: @post, action_prefix: "post_#{@post.id}" }
      )
    )
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: updatable_frames
      end
    end
  end


  def set_post
    @post = Post.find(params[:id])
  end
end
