# frozen_string_literal: true

# SharedPost controller
class SharedPostController < ApplicationController
  def index
    @sharedPosts = SharedPost.all.order(created_at: :desc).load_async
    debug
  end

  def create
    @post = Post.find(params[:id])

    return if @post.shared_by?(current_user)

    new_repost = @post.shared_posts_relation.create(user: current_user) 

    updatable_frames = get_updatable_reposts_frames()
    updatable_frames.append(
      turbo_stream.prepend("posts_list",
        partial: 'shared_posts/shared_post',
        locals: { repost: new_repost })
    )

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: updatable_frames
      end
    end

  end

  def destroy
    @post = Post.find(params[:id])

    return unless @post.shared_by?(current_user)

    # Getting post
    shared_post = @post.shared_posts_relation.find_by(user: current_user)
    
    if shared_post
      shared_post.destroy
    end

    updatable_frames = get_updatable_reposts_frames()
    updatable_frames.append(
      turbo_stream.remove(
        "shared_post_#{shared_post.id}_by_user_#{shared_post.user.id}"
      )
    )

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: updatable_frames
      end
    end
      
  end

  private

  def get_updatable_reposts_frames
    visible_reposts = @post.shared_posts_relation.where(user_id: @user_suggestions.follows_ids(true))
    updatable_frames = visible_reposts.map { |repost|
      action_prefix = "shared_post_#{repost.id}_by_user_#{repost.user.id}"
      turbo_stream.replace("#{action_prefix}_share_button",
            partial: 'shared_posts/shared_post_button',
            locals: { post: @post, action_prefix: action_prefix })
    }

    updatable_frames.append(
      turbo_stream.replace("post_#{@post.id}_share_button",
        partial: 'shared_posts/shared_post_button',
        locals: { post: @post, action_prefix: "post_#{@post.id}" }
      )
    )

    updatable_frames
  end

end
