class SearchController < ApplicationController
  def index
    @query = params[:query]

    if @query.present?
      @users = User.where('username LIKE ?', "%#{@query}%")
      @posts = Post.where('content LIKE ?', "%#{@query}%")
      @validate = true
    else
      @validate = false
    end
  end

end
