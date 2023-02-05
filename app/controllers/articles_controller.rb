class ArticlesController < ApplicationController
  before_action :authenticate_user!, except: [:show, :index]
  before_action :find_article, only: [:show, :edit, :update, :destroy]

  def index
    @articles = Article.includes(:user).order(created_at: :desc).page(params[:page]).per(9)
  end

  def show
    @user = @article.user
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    @article.user_id = current_user.id
    if @article.save
      redirect_to @article, notice: "記事を投稿しました"
    else
      render :new, status: :unprocessable_entity
    end

  end

  def update
    if @article.update(article_params)
      redirect_to @article, notice: "記事を更新しました"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def edit
    unless @article.user == current_user
      redirect_to root_path, alert: "他人の記事を編集することは出来ません"
    end
  end
  
  def destroy
    @article.destroy
      redirect_to root_path, notice: "投稿を削除しました"
  end

  private

  def find_article
    @article = Article.find(params[:id])
  end

  def article_params
    params.require(:article).permit(:title, :body, :image)
  end

end
