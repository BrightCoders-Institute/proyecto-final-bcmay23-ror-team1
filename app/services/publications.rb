class Publications
  attr_reader :page_number, :per_page

  def initialize(users_ids, page_number, per_page)
    @users_ids = users_ids
    @page_number = page_number.present? ? page_number.to_i : 1
    @per_page = per_page
  end

  def real_posts
    Post.where(deleted: false, user_id: @users_ids)
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

  private

  def paginate(posts)
    posts.paginate(page: @page_number, per_page: 10)
  end

end
