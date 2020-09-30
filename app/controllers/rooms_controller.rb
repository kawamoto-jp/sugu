class RoomsController < ApplicationController
  def new
    @another_user = User.where.not(id: current_user.id)
    if (Favorite.user_id.current_user == Favorite.@another_user.user_info_id) && (Favorete.current_user.user_info_id == Favorite.@another_user.user_id)


  end
end
