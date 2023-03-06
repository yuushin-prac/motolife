class LikesController < ApplicationController
  before_action :set_article

  def create
    @like = Like.new(user_id: current_user.id, article_id: @article.id)
    @like.save
    redirect_to article_path(params[:article_id]) 
  end

  def destroy
    @like = Like.find_by(user_id: current_user.id, article_id: @article.id)
    @like.destroy
    redirect_to article_path(params[:article_id]) 
  end
  
  private

    def set_article
      @article = Article.find_by(id: params[:article_id])
    end
end
