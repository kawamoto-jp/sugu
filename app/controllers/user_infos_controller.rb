class UserInfosController < ApplicationController

  before_action :search_user_info, only: [:index, :search]
  
  def index
    @user_infos = UserInfo.all.all.order("created_at DESC")
    set_user_info_column
  end

  def search
    @results = @p.result.includes(:area)
  end

  def new
    @user_info = UserInfo.new
  end

  def create
    @user_info = UserInfo.new(user_info_params)
    if UserInfo.where(user_id: current_user.id).present?
      redirect_to action: :false
    else
      @user_info.save
      redirect_to root_path
    end
  end

  def edit
    @user_info = UserInfo.find(params[:id])
  end

  def update
    user_info = UserInfo.find(params[:id])
    if user_info.update(user_info_params)
      redirect_to root_path
    else
      render :edit
    end
  end

  def destroy
    unless user.user_signed_id?
      user_info.destroy
    end
  end


  def pre_page
    @user_infos = UserInfo.all
  end



  private

  def set_user_info_column
    @user_info_area_id = UserInfo.select("area_id").distinct  # 重複なくnameカラムのデータを取り出す
  end

  def search_user_info
    @p = UserInfo.ransack(params[:q])  # 検索オブジェクトを生成
  end

  def user_info_params
    params.require(:user_info).permit(:gender, :image, :text, :people_num_id, :area_id).merge(user_id: current_user.id)
  end

end
