# frozen_string_literal: true

# Application controller
class ApplicationController < ActionController::Base
  layout :layout_by_resource
  before_action :layout_variables

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
        # add one item to create a new side_bar_button
      ]
    end
end
