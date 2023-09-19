# frozen_string_literal: true

# Likes controller
class LikesController < ApplicationController
  before_action :set_post

  def create
    @post.likes.create(user: current_user) unless @post.liked_by?(current_user)

    render partial: 'likes/like', locals: { post: @post }
  end

  def destroy
    @post.likes.find_by(user: current_user).destroy if @post.liked_by?(current_user)
    render partial: 'likes/like', locals: { post: @post }
  end

  private 

  def set_post
    @post = Post.find(params[:id])
  end
end
