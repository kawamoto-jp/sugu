class UserInfosController < ApplicationController
  before_action :search_user_info, only: [:index, :search]
  before_action :authenticate_user!, except: [:index, :search]

  def index
    @promotion_male = UserInfo.joins(:user).where(users: { gender: "男"}).count
    @promotion_female = UserInfo.joins(:user).where(users: { gender: "女"}).count
    unless user_signed_in?
      @user_infos = UserInfo.all.order(updated_at: :desc)
      set_user_info_column
      return
    end
    if current_user.gender == "女"
      @user_infos = UserInfo.joins(:user).where(users: { gender: "男"}).order(updated_at: :desc)
      set_user_info_column
    elsif current_user.gender == "男"
      @user_infos = UserInfo.joins(:user).where(users: { gender: "女"}).order(updated_at: :desc)
      set_user_info_column
    end
  end

  def search
    @promotion_male = UserInfo.joins(:user).where(users: { gender: "男"}).count
    @promotion_female = UserInfo.joins(:user).where(users: { gender: "女"}).count
    unless user_signed_in?
      @results = @p.result.all.order(id: "DESC")
      set_user_info_column
      return
    end
    if current_user.gender == "女"
      @results = @p.result.joins(:user).where(users: { gender: "男"}).order(updated_at: :desc)
      set_user_info_column
    elsif current_user.gender == "男"
      @results = @p.result.joins(:user).where(users: { gender: "女"}).order(updated_at: :desc)
      set_user_info_column
    end
  end

  def new
    if UserInfo.where(user_id: current_user.id).present?
      redirect_to action: :false
    else
      @user_info = UserInfo.new
    end
  end

  def create
    @user_info = UserInfo.new(user_info_params)
    if @user_info.valid?
      @user_info.save
      flash[:notice] = 'Successfully!'
      redirect_to pre_page_user_infos_path
    else
      render :new
    end
  end

  def edit
    @user_info = UserInfo.find(params[:id])
  end

  def update
    @user_info = UserInfo.find(params[:id])
    if @user_info.update(user_info_params)
      flash[:notice] = 'Successfully!'
       redirect_to pre_page_user_infos_path
    else
      render :edit
    end
  end

  def destroy
  end

  def pre_page
    @user_infos = UserInfo.all
  end


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