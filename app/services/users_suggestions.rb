class UsersSuggestions
  attr_accessor :page_number, :per_page

  def initialize(current_user, page_number, per_page)
    @current_user = current_user
    @page_number = page_number
    @per_page = per_page
  end

  def next_page
    @page_number + 1
  end

  # Ids of the followed users to filter
  def follows_ids
    Follow.where(follower: @current_user)
          .pluck(:following_id)
          .append(@current_user.id)
  end

  # Suggested users on the right area of the application layout
  def to_follow
    User.where.not(id: self.follows_ids).order('RANDOM()').limit(3)
  end

# Suggested users on the modal
  def firsts_to_follow
    User.where.not(id: self.follows_ids).paginate(page: @page_number, per_page: @per_page)
  end

end
