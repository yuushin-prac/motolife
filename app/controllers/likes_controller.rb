class LikesController < ApplicationController
  before_action :set_article

  def create
    @like = Like.new(user_id: current_user.id, article_id: @article.id)
    @like.save
  end

  def destroy
    @like = Like.find_by(user_id: current_user.id, article_id: @article.id)
    @like.destroy
  end
  
  private

    def set_article
      @article = Article.find_by(id: params[:article_id])
    end
end
