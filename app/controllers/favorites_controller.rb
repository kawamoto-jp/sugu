class FavoritesController < ApplicationController
  def create
    favorite = current_user.favorites.build(user_info_id: params[:user_info_id])
    favorite.save
    redirect_to user_infos_path
  end

  def destroy
    favorite = Favorite.find_by(user_info_id: params[:user_info_id], user_id: current_user.id)
    favorite.destroy
    redirect_to user_infos_path
  end
end
