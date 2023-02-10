class UsersController < ApplicationController
  before_action :authenticate_user!, except: :show
  before_action :find_user

  def show
    @articles = @user.articles.order(created_at: :desc).page(params[:page]).per(8).with_rich_text_content
  end

  def edit
    unless @user.id == current_user.id
      redirect_to root_path, alert: "他人のアカウントを編集することは出来ません"
    end
  end

  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html{ redirect_to :user }
        format.js
      else
        format.html { render :user }
        format.js
      end
    end
  end

  def destroy
    @user.destroy
      redirect_to root_path, notice: "アカウントを削除しました"
  end

  private
  
  def find_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :self_introduction, :profile_image)
  end

end
