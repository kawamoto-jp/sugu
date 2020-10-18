class RoomsController < ApplicationController
  def index
    @favorite_user_infos = current_user.favorite_user_infos #情報を取ってる
    @favorite_users = current_user.user_info.favorite_users #ユーザーを取ってる
    x = current_user.favorite_user_infos.all.pluck(:user_id)
    y = current_user.user_info.favorite_users.ids
    z = x & y
    @match = User.where(id: z)
  end

  def new
    @room = Room.new
    @favorite_user_infos = current_user.favorite_user_infos #情報を取ってる
    @favorite_users = current_user.user_info.favorite_users #ユーザーを取ってる
    x = current_user.favorite_user_infos.pluck(:user_id)
    y = current_user.user_info.favorite_users.ids
    z = x & y
    @matched = User.where(id: z)

    u = current_user.rooms.includes(:users).map{|room| room.users.ids}.flatten.uniq
    a = z - u
    @match = User.where(id: a)
  end

  def create
    @room = Room.new(room_params)
    if @room.user_ids.length == 2
      @room.save
      redirect_to rooms_path
    else
      redirect_to false_user_infos_path
    end
  end


  private

  def room_params
    params.require(:room).permit(user_ids:[])
  end

end
