class FavoritesController < ApplicationController
  before_action :set_user_info, only: [:create, :destroy]

  def index
    @users = User.all
    @favorite_user_infos = current_user.favorite_user_infos #情報を取ってる
    @favorite_users = current_user.user_info.favorite_users #ユーザーを取ってる
    x = current_user.favorite_user_infos.pluck(:user_id)
    y = current_user.user_info.favorite_users.ids
    z = x & y
    @match = User.where(id: z)
  end

  # def create
  #   favorite = current_user.favorites.build(user_info_id: params[:user_info_id])
  #   favorite.save
  #   redirect_to root_path
  # end

  # def destroy
  #   favorite = Favorite.find_by(user_info_id: params[:user_info_id], user_id: current_user.id)
  #   favorite.destroy
  #   redirect_to root_path
  # end

  def create
    # @user_info = UserInfo.find(params[:user_info_id])
    favorite = current_user.favorites.build(user_info_id: params[:user_info_id])
    favorite.save
  end

  def destroy
    # @user_info = UserInfo.find(params[:user_info_id])
    favorite = Favorite.find_by(user_info_id: params[:user_info_id], user_id: current_user.id)
    favorite.destroy
  end

  private
  def set_user_info
    @user_info = UserInfo.find(params[:user_info_id])
  end

  
end