require 'rails_helper'

describe User do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録がうまくいくとき' do
      it "nickname、gender、email、passwordとpassword_confirmationが存在すれば登録できる" do
        expect(@user).to be_valid
      end
    end

    context '新規登録がうまくいかないとき' do
      it "nicknameが空だと登録できない" do
        @user.nickname = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end
      it "genderを選択していないと登録できない" do
        @user.gender = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Gender can't be blank")
      end
      it "emailが空では登録できない" do
        @user.email = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end
      it "emailが@を含み、かつその後に.がないと登録できない" do
        @user.email = "kkk@kkk"
        @user.valid?
        expect(@user.errors.full_messages).to include("Email is invalid")
      end
      it "重複したemailが存在する場合登録できない" do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include("Email has already been taken")
        another_user.valid?
      end
      it "passwordが空では登録できない" do
        @user.password = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end
      it "passwordが5文字以下でないと登録できない" do
        @user.password ="aaa11"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
        
      end
      it "passwordに半角英数字を含んでいないと登録できない" do
        @user.password = "aaaaaaa"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is invalid")
        
      end
      it "passwordが存在してもpassword_confirmationが空では登録できない" do
        @user.password = "aaaa111"
        @user.password_confirmation = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
    end
  end
end