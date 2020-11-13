class ApplicationController < ActionController::Base

  # before_action :authenticate_user!
  protect_from_forgery with: :exception#セキュリティ対策
  before_action :configure_permitted_parameters, if: :devise_controller?
  # before_action :redirect_to_root, only: [:render_404]

  protected
  def after_sign_in_path_for(resource)
    root_path
  end

  def after_sign_up_path_for(resource)
    root_path
  end

  def after_sign_out_path_for(resource)
    root_path
  end

  def configure_permitted_parameters
    add_attrs = [ :email, :name, :password, :password_confirmation, :image, :area, :experience, :stance, :history, :introduction, :is_deleted ]
    devise_parameter_sanitizer.permit :sign_up, keys: add_attrs
    devise_parameter_sanitizer.permit :account_update, keys: add_attrs
    devise_parameter_sanitizer.permit :sign_in, keys: add_attrs
  end

  def redirect_to_root
    redirect_to root_path
  end
end


  # before_action :user_search_query
  # protected
  # def user_search_query
  #   @q = User.ransack(params[:q])
  #   @users = @q.result(distinct: true)
  # end

