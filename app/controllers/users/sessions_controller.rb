# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  
  # def destroy
  #   # binding.pry
  #   # current_user.user_info #ユーザ毎の情報を得る
  #   UserInfo.where(user_id: current_user.id).destroy
  #   # user.pluck(:id) #ユーザ情報を削除（退会）
  #   redirect_to root_path #削除後、rootに移動させる
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
