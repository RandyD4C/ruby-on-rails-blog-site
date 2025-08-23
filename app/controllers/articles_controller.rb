class ArticlesController < ApplicationController
  before_action :set_article, only: %i[ show edit update destroy ]
  before_action :count_user, only: %i[ new edit ]

  def index
    # Instead of Article.all, we use Article.includes(:user) 
    # to eager load users for each article to avoid N+1 queries
    @articles = Article.includes(:user)

    if params[:query].present?
      search = "%#{params[:query]}%"
      @articles = @articles.joins(:user)
                          # Since SQLite3 doesn't support ILIKE, we use LIKE to perform case-insensitive search
                          # for compatibility between SQLite3 and PostgreSQL
                          .where("LOWER(articles.title) LIKE LOWER(?) OR LOWER(users.name) LIKE LOWER(?)", search, search)
    end
  end

  def show
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)

    if @article.save
      redirect_to @article
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @article.update(article_params)
      redirect_to @article
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @article.destroy

    redirect_to root_path, status: :see_other
  end

  private
    def article_params
      params.require(:article).permit(:title, :body, :status, :user_id)
    end

    def set_article
      @article = Article.find(params[:id])
    end

    def count_user
      @user_count = User.count
    end
end
