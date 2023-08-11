class PostsController < ApplicationController
  before_action :authenticate_user!

  def index
    @posts = Post.all
    
    # Indivitual post for creation form
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id

    if @post.save
      redirect_to posts_path
    else
      @errors = @post.errors.full_messages
      render 'posts/index', status: :unprocessable_entity
    end

  end

  private 

  def post_params
    params.require(:post).permit(:content, :user_id, images: [])
  end

end
