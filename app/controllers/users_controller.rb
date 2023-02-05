class UsersController < ApplicationController
  before_action :find_user

  def show
    @articles = @user.articles.order(created_at: :desc).page(params[:page]).per(5)
  end

  def edit
    unless @user.id == current_user.id
      redirect_to root_path, alert: "他人のアカウントを編集することは出来ません"
    end
  end

  def update
    @user.update(user_params)
      redirect_to user_path(@user.id), notice: "記事を更新しました"
  end

  def destroy
  end

  private
  
  def find_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :self_introduction, :profile_image)
  end

end
