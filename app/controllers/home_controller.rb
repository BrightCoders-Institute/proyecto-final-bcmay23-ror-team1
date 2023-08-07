# frozen_string_literal: true

# Home controller
class HomeController < ApplicationController
  before_action :authenticate_user!

  def index; end
end
