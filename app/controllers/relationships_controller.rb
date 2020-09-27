class RelationshipsController < ApplicationController
  def create
    follow = current_user.active_relationships.build(follower_id: params[:user_info.id])
    follow.save
    redirect_to user_infos_path
  end

  def destroy
    binding.pry
    follow = current_user.user_info.active_relationships.find_by(follower_id: params[:user_info_id])
    follow.destroy
    redirect_to root_path
  end
end
