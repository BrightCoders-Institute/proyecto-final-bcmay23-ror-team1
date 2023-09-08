class PostsController < ApplicationController
  before_action :authenticate_user!

  def index
    @posts = Post.all.includes(:shared_posts_relation).with_attached_images.order(created_at: :desc).load_async
    @sharedPosts = SharedPost.all.order(created_at: :desc).load_async

    @posts = (@posts + @sharedPosts).sort_by { |post| post.created_at }
    @posts = @posts.reverse

    
    # Indivitual post for creation form
    @post = Post.new
  end

  def show
    @post = Post.find(params[:id])
    @comments = Post.comments(@post)
    @ancestors = Post.ancestors(@post, [])
  end

  def new
    @post = Post.new
    if params[:parent_id].present?
      @parent = Post.find(params[:parent_id])
      @post.parent_id = @parent.id
      render :new_comment
    end
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
    params.require(:post).permit(:content, :user_id, :parent_id, images: [])
  end


end
