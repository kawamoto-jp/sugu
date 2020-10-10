require 'rails_helper'

describe UserInfo do
  before do
    @user_info = FactoryBot.build(:user_info)
  end

  describe '投稿の保存' do
    context "投稿が保存できる場合" do
      it "画像、ひとこと、エリア、人数があれば投稿は保存される" do
        expect(@user_info).to be_valid
      end
    end

    context "投稿が保存できない場合" do
      it "画像がないと投稿は保存できない" do
        @user_info.image = nil
        @user_info.valid?
        expect(@user_info.errors.full_messages).to include("Image can't be blank")
      end
      it "ひとことがないと投稿は保存できない" do
        @user_info.text = ""
        @user_info.valid?
        expect(@user_info.errors.full_messages).to include("Text can't be blank")
      end
      it "エリアが選択されていないと投稿は保存できない" do
        @user_info.area_id = ""
        @user_info.valid?
        expect(@user_info.errors.full_messages).to include("Area can't be blank")
      end
      it "人数が選択されていないと投稿は保存できない" do
        @user_info.people_num_id = ""
        @user_info.valid?
        expect(@user_info.errors.full_messages).to include("People num can't be blank")
      end
      it "ユーザーが紐付いていないと投稿は保存できない" do
        @user_info.user = nil
        @user_info.valid?
        expect(@user_info.errors.full_messages).to include("User must exist")
      end
    end
  end
end
