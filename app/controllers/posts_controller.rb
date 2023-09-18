class PostsController < ApplicationController
  # before_action :authenticate_user!
  before_action :redirect_if_not_signed_in!

  def index

    followings_ids = Follow.where(follower_id: current_user.id).pluck(:following_id)
    followings_ids.append(current_user.id)
    
    @posts = Post.where(deleted: false, user_id: followings_ids)
                  .includes(:shared_posts_relation)
                  .with_attached_images.order(created_at: :desc)
                  .load_async

    @sharedPosts = SharedPost.all.order(created_at: :desc).load_async

    @posts = (@posts + @sharedPosts).sort_by { |post| post.created_at }
    @posts = @posts.reverse
    
    # Indivitual post for creation form
    @post = Post.new
  end

  def show
    @post = Post.find_by(id: params[:id])
    if @post.present?
      @comment = Post.new(parent: @post)
      @comments = Post.comments(@post)
      @ancestors = Post.ancestors(@post, [])
    end
  end

  def new
    @post = Post.new
    if params[:parent_id].present?
      @parent = Post.find(params[:parent_id])
      @post.parent_id = @parent.id
      render "comments/new_modal"
    end
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id

    if @post.save

      if @post.parent.present?  

        flash[:posted] = "Your comment was posted!"

        respond_to do |format|
          format.turbo_stream do
            render turbo_stream: [
              turbo_stream.update(
                "comment_#{@post.parent.id}",
                partial: "comments/comment-button",
                locals: { post: @post.parent }
              ),
              turbo_stream.update(
                "flash_message",
                partial: "shared/flash_message",
                locals: { post: @post }
              )
            ]
          end
        end

      else
      
        flash[:posted] = "Posted successfully!"
        respond_to do |format|
          format.turbo_stream do
            render turbo_stream: [
              turbo_stream.update(
                "flash_message",
                partial: "shared/flash_message",
                locals: { post: @post }
              ),
              turbo_stream.update(
                "form_new_post",
                partial: "posts/new/form",
                locals: { post: Post.new }
              )
            ]
          end
        end

      end

    else
      @errors = @post.errors.full_messages
      render 'posts/index', status: :unprocessable_entity
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.update(deleted: true)
    flash[:notice] = "Your post was deleted"
    render turbo_stream:
      turbo_stream.replace("frame_post_#{@post.id}", partial: "posts/deleted", locals: { post: @post })
  end
  
  private 

  def post_params
    params.require(:post).permit(:content, :user_id, :parent_id, images: [])
  end


end
