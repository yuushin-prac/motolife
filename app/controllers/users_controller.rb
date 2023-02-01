class UsersController < ApplicationController

  def show
    user = User.find(params[:id])
    @name = current_user.name
    @articles = current_user.articles
  end
end
