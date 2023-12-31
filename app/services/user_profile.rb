class UserProfile
  attr_reader :user, :tab
  include Rails.application.routes.url_helpers

  def initialize(username, tab, publications)
    @user = User.find_by(username: username)
    @tab = tab.blank? ? 'posts' : tab
    @publications = publications
  end

  def avatar
    @user.avatar
  end
  
  def banner
    @user.banner
  end

  def tabs
    [
      {
        "route" => user_path(username: @user.username, tab: "posts"),
        "text" => "Posts",
        "active" => @tab == "posts" || @tab.blank?,
      },
      {
        "route" => user_path(username: @user.username, tab: "likes"),
        "text" => "Likes",
        "active" => @tab == "likes",
      },
      {
        "route" => user_path(username: @user.username, tab: "comments"),
        "text" => "Comments",
        "active" => @tab == "comments",
      },
    ]
  end

  def creation_date
    user_created_month_number = @user.created_at.strftime("%m").to_i 
    user_created_month_name = Date::MONTHNAMES[user_created_month_number]
    user_created_year = @user.created_at.strftime("%Y")
    "Joined in #{user_created_month_name} #{user_created_year}"
  end

  def real_posts
    @user.posts
      .where(deleted: false)
      .with_attached_images
      .order(created_at: :desc)
      .load_async
  end

  def posts
    shared_posts = @user.shared_posts_relation.order(created_at: :desc).load_async
    posts_and_shared = (self.real_posts + shared_posts).sort_by { |post| post.created_at }
    @publications.paginate(posts_and_shared.reverse)
  end

  def liked_posts
    liked_posts = @user.liked_posts.where(deleted: false)
    @publications.paginate(liked_posts)
  end

  def comments
    comments = @user.comments.where(deleted: false)
    @publications.paginate(comments)
  end

end
