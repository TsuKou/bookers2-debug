class ApplicationController < ActionController::Base
  # before_action :authenticate_user!,except: [:top,:about]を削除し「book,user_controller」へ記述
  before_action :configure_permitted_parameters, if: :devise_controller?



  def after_sign_in_path_for(resource)
    user_path(current_user)
    # 解説確認しbooks_pathからuser_path(resourse)へ修正

  end

  def after_sign_out_path_for(resource)
    root_path
  end

  private

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email])
  end
end
