# frozen_string_literal: true

# Application controller
class ApplicationController < ActionController::Base
  layout :layout_by_resource
  before_action :layout_variables
  before_action :authenticate_user!
  # before_action :set_user

  private
    def layout_by_resource
      if devise_controller?
        "devise"
      else
        "application"
      end
    end

    def layout_variables
      @side_bar_buttons = [
        {
          "route" => root_path,
          "icon_class" => 'fas fa-home',
        },
        {
          "route" => current_user ? user_path(current_user) : nil,
          "icon_class" => 'fas fa-user',
        },
        {
          "route" => search_index_path,
          "icon_class" => 'fas fa-search',
        },
        # add one item to create a new side_bar_button
      ]

      if current_user
        @notifications_number = Notification.where("receiver_id = ?", current_user.id).count
        @follow_suggestions = User.all.where('id != ? ', current_user.id)
      end
    end

    # needed to application layout becuse from there user info is displayed
    def set_user
      @user = User.find(params[:user_id]) if params[:user_id]
    end
end
