class SearchController < ApplicationController
  def index
    @query = params[:query]
    @users = User.where('username ILIKE ?', "%#{@query}%")
    @posts = Post.where('content ILIKE ?', "%#{@query}%")
  end
end
