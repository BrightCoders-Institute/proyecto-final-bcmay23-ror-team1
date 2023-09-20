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

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: [

          turbo_stream.replace("post_#{@post.id}_share_button",
            partial: 'shared_posts/shared_post_button',
            locals: { post: @post, action_prefix: "post_#{@post.id}" }),

          turbo_stream.prepend("posts_list",
            partial: 'shared_posts/shared_post',
            locals: { repost: new_repost })

        ]
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

    updatable_frames = [
      turbo_stream.update("shared_post_#{shared_post.id}_by_user_#{shared_post.user.id}",
        partial: 'shared_posts/removed', locals: { repost: @post }
      ),
      turbo_stream.replace("post_#{@post.id}_share_button",
        partial: 'shared_posts/shared_post_button',
        locals: { post: @post, action_prefix: "post_#{@post.id}" })
    ]

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: updatable_frames
      end
    end
      
  end

end
