class FavoritesController < ApplicationController
  def index
    @users = User.all
    @favorite_user_infos = current_user.favorite_user_infos #情報を取ってる
    @favorite_users = current_user.user_info.favorite_users #ユーザーを取ってる
    binding.pry
    @matcing = @favorite_user_infos & @favorite_users.ids
    
    
  end

  def create
    favorite = current_user.favorites.build(user_info_id: params[:user_info_id])
    favorite.save
    redirect_to root_path
  end

  def destroy
    favorite = Favorite.find_by(user_info_id: params[:user_info_id], user_id: current_user.id)
    favorite.destroy
    redirect_to root_path
  end
end