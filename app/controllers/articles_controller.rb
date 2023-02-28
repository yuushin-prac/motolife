class ArticlesController < ApplicationController
  before_action :authenticate_user!, except: [:show, :index]
  before_action :find_article, only: [:show, :edit, :update, :destroy]

  def index
    #ソート機能　リファクタリング予定
    if params[:show_blog]
      @articles = Article.eager_load(:user).show_blog.order(created_at: :desc).page(params[:page]).per(9).with_rich_text_content
    elsif params[:show_maintenance_note]
      @articles = Article.eager_load(:user).show_maintenance_note.order(created_at: :desc).page(params[:page]).per(9).with_rich_text_content
    else
      @articles = Article.eager_load(:user).order(created_at: :desc).page(params[:page]).per(9).with_rich_text_content
    end
  end

  def show
    @user = @article.user
    @comments = @article.comments
    if user_signed_in?
     @comment = current_user.comments.new
    end
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
      redirect_to root_path, notice: "記事を削除しました"
  end

  private

  def find_article
    @article = Article.find(params[:id])
  end

  def article_params
    params.require(:article).permit(:image, :category, :title, :content)
  end

end
