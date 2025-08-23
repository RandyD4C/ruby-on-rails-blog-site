class UsersController < ApplicationController
    before_action :set_user, only: %i[ show edit update destroy ]

  def index
    @users = User.all
  end

  def show
    @articles = @user.articles
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to @user
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to @user
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @user.destroy
    redirect_to users_path
  end

  def search
    users = User.where("name ILIKE ?", "%#{params[:term]}%").limit(20)
    render json: users.map { |user| { value: user.id, label: user.name } }
  end

  private
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:name, :email, :dob)
    end
end
