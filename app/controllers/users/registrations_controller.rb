# frozen_string_literal: true

# Registrations controller
class Users::RegistrationsController < Devise::RegistrationsController
  layout 'layouts/application', only: [:show]
  before_action :configure_sign_up_params, only: [:create]
  before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  # def new
  #   super
  # end

  # POST /resource

  def avatar
    @user = User.new
  end

  def signup_set_avatar
    if params[:user].present? && params[:user][:avatar].present?
      current_user.update(avatar: params[:user][:avatar])
    else
      random_avatar_path = Dir.glob("app/assets/images/avatars/*").sample
      random_avatar_blob = ActiveStorage::Blob.create_before_direct_upload!(
        filename: File.basename(random_avatar_path),
        byte_size: File.size(random_avatar_path),
        checksum: Digest::MD5.base64digest(File.read(random_avatar_path))
      )

      random_avatar_blob.upload(File.open(random_avatar_path))

      current_user.update(avatar: random_avatar_blob)
    end
    redirect_to root_path
  end

  
  def show
    @tab = params[:tab]
    @tab = "posts" if @tab.blank?
    
    @user = User.find(params[:id])
    
    @navigation_tabs = [
      {
        "route" => user_path(@user, tab: "posts"),
        "text" => "Posts",
        "active" => @tab == "posts" || @tab.blank?,
      },
      {
        "route" => user_path(@user, tab: "likes"),
        "text" => "Likes",
        "active" => @tab == "likes",
      },
    ]
    
    
    user_created_month_number = @user.created_at.strftime("%m").to_i 
    user_created_month_name = Date::MONTHNAMES[user_created_month_number]
    
    user_created_year = @user.created_at.strftime("%Y")
    
    @user_created_date = "Joined in #{user_created_month_name} #{user_created_year}"
    
  end

  def destroy
    User.transaction do
      DeletedUser.create(id: current_user.id, username: current_user.username)
      
      current_user.follower_records.destroy_all
      current_user.swap_posts_to_deleted_user
      current_user.destroy
    end

    redirect_to root_path
  end

  def edit
    render 'edit'
  end
  
  protected

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :username])
  end

  # If you have extra params to permit, append them to the sanitizer.
  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :biography])
  end

  # The path used after sign up.
  def after_sign_up_path_for(resource)
    signup_set_avatar_path
  end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end

end
