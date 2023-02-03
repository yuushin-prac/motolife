class UsersController < ApplicationController

  def show
    user = User.find(params[:id])
    @name = user.name
    @articles = user.articles
  end
end
