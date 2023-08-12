class PostsController < ApplicationController
  before_action :authenticate_user!

  def index
    @posts = Post.all.with_attached_images.order(created_at: :asc).load_async
    
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

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to posts_path, status: :see_other
  end
  
  private 

  def post_params
    params.require(:post).permit(:content, :user_id, images: [])
  end


end
