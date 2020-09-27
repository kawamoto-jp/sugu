class UserInfosController < ApplicationController

  before_action :search_user_info, only: [:index, :search]
  
  def index
    @promotion_male = UserInfo.joins(:user).where(users: { gender: "男"}).count
    @promotion_female = UserInfo.joins(:user).where(users: { gender: "女"}).count
    unless user_signed_in?
      @user_infos = UserInfo.all.order(id: "DESC")
      set_user_info_column
      return
    end
    if current_user.gender == "女"
      @user_infos = UserInfo.joins(:user).where(users: { gender: "男"})
      set_user_info_column
    elsif current_user.gender == "男"
      @user_infos = UserInfo.joins(:user).where(users: { gender: "女"})
      set_user_info_column
    end
  end

  def search
    unless user_signed_in?
      @results = @p.result.all.order(id: "DESC")
      set_user_info_column
      return
    end
    if current_user.gender == "女"
      @results = @p.result.joins(:user).where(users: { gender: "男"})
      set_user_info_column
    elsif current_user.gender == "男"
      @results = @p.result.joins(:user).where(users: { gender: "女"})
      set_user_info_column
    end
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
    
  end


  def pre_page
    @user_infos = UserInfo.all
  end

  # ==============追加================
  def follows
    user_info = UserInfo.find(params[:id])
    @user_infos = user_info.followings
  end

  def followers
    user_info = UserInfo.find(params[:id])
    @user_infos = user_info.followers
  end
# ==============追加================



  private

  def search_user_info
    @p = UserInfo.ransack(params[:q])
  end

  def set_user_info_column
    @user_info_area = UserInfo.select("area_id").distinct  # 重複なくnameカラムのデータを取り出す
    @user_info_people_num = UserInfo.select("people_num_id").distinct  # 重複なくnameカラムのデータを取り出す
  end

  

  def user_info_params
    params.require(:user_info).permit(:gender, :image, :text, :people_num_id, :area_id).merge(user_id: current_user.id)
  end

end