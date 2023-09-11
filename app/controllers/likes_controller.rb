# frozen_string_literal: true

# Likes controller
class LikesController < ApplicationController
  
  def create
    @post = Post.find(params[:id])
    @post.likes.create(user: current_user) unless @post.liked_by?(current_user)
    render turbo_stream:
      turbo_stream.replace("like_post_#{@post.id}", partial: 'likes/like', locals: { post: @post })
  end

  def destroy
    @post = Post.find(params[:id])
    @post.likes.find_by(user: current_user).destroy if @post.liked_by?(current_user)
    render turbo_stream:
      turbo_stream.replace("like_post_#{@post.id}", partial: 'likes/like', locals: { post: @post })
  end
end
