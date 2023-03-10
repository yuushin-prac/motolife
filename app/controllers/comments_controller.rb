class CommentsController < ApplicationController

  def create
    @article = Article.find(params[:article_id])
    @comment = current_user.comments.new(comment_params)
    if @comment.save
      redirect_to article_path(@article), notice: 'コメントを投稿しました'
    else
      redirect_to article_path(@article), alert: 'コメントは1文字以上140文字以下にしてください'
    end
  end

  def destroy
    Comment.find_by(id: params[:id], article_id: params[:article_id]).destroy
    redirect_to article_path(params[:article_id]), alert: 'コメントを削除しました'
  end

  private

  def comment_params
    params.require(:comment).permit(:comment_content, :article_id)
  end

end
