class RoomsController < ApplicationController
  def new
    @room_users = Room.joins(:user).user_info.where(user_infos :id)
  end
end
