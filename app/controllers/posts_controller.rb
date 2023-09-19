class PostsController < ApplicationController
  # before_action :authenticate_user!
  before_action :redirect_if_not_signed_in!

  def index

    users_ids = @user_suggestions.follows_ids
    @publications = Publications.new(users_ids, params[:page], 10)

    @post = Post.new # fills the the "new post" form

    if @publications.posts.count.zero?
      render turbo_stream:
        turbo_stream.append('posts_list', partial: 'posts/no-posts')
      
    elsif params[:page].present?
      render turbo_stream:
        turbo_stream.append(:posts_list,
          partial: 'posts/posts-list', locals: { posts: @publications.posts } )
    end
           
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
