# frozen_string_literal: true

# Application controller
class ApplicationController < ActionController::Base
  layout :layout_by_resource
  before_action :layout_variables
  # before_action :authenticate_user!
  # before_action :set_user

  def route_not_found
    render 'layouts/not_found', status: :not_found, layout: true
  end

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

      if current_user.present?
        @notifications_number = Notification.where(receiver: current_user, read: false).count
        @user_suggestions = UsersSuggestions.new(current_user, 1, 5)
      end
    end

    # needed to application layout becuse from there user info is displayed
    def set_user
      @user = User.find(params[:user_id]) if params[:user_id]
    end

    def redirect_if_not_signed_in!
      unless user_signed_in?
        redirect_to root_path # Redirige a la vista inicial que desees
      end
    end
    
end
