# frozen_string_literal: true

# SharedPost controller
class SharedPostController < ApplicationController
  def index
    @sharedPosts = SharedPost.all.order(created_at: :desc).load_async
    debug
  end

  def create
    @post = Post.find(params[:id])
    @post.shared_posts_relation.create(user: current_user) unless @post.shared_by?(current_user)
    render turbo_stream:
      turbo_stream.replace("shared_#{@post.id}", partial: 'shared_posts/shared_post_button', locals: { post: @post })
  end

  def destroy
    @post = Post.find(params[:id])

    # Getting post
    shared_post = @post.shared_posts_relation.find_by(user: current_user)
    pp @post.shared_posts_relation
    
    if shared_post
      shared_post.destroy if @post.unshared_by?(current_user)
    end

    render turbo_stream:
      turbo_stream.replace("shared_#{@post.id}", partial: 'shared_posts/shared_post_button', locals: { post: @post })
  end

end