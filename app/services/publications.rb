class Publications
  attr_reader :page_number, :per_page

  def initialize(user, page_number, per_page)
    @user = user
    @page_number = page_number.present? ? page_number.to_i : 1
    @per_page = per_page
  end

  def real_posts
    if @user.is_a?(Array)
      return Post.where(deleted: false, user_id: @user)
          .includes(:shared_posts_relation)
          .with_attached_images
          .order(created_at: :desc)
          .load_async
    end
    Post.where(deleted: false, user: User.find_by(username: @user))
          .includes(:shared_posts_relation)
          .with_attached_images
          .order(created_at: :desc)
          .load_async
  end

  def posts
    shared_posts = SharedPost.all.order(created_at: :desc).load_async
    posts = (self.real_posts + shared_posts).sort_by { |post| post.created_at }
    self.paginate(posts.reverse)
  end

  def next_page
    @page_number + 1
  end

  def paginate(posts)
    posts.paginate(page: @page_number, per_page: @per_page)
  end

end
