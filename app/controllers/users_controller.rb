class UsersController < ApplicationController
  before_action :ensure_correct_user, only: [:update]

  def index
    @users = User.page(params[:page])
    if params[:sort] == "new_arrival_order"
      @users = User.page(params[:page]).order(created_at: :desc)
    elsif params[:sort] == "posting_order"
      @users = User.page(params[:page]).order(created_at: :asc)
    else
      @users = User.page(params[:page]).order(created_at: :desc)
    end
  end

  def show
    # ソート機能
    @user = User.find(params[:id])
    if params[:sort] == "new_arrival_order"
      @books = @user.books.page(params[:page]).order(created_at: :desc)
    elsif params[:sort] == "posting_order"
      @books = @user.books.page(params[:page]).order(created_at: :asc)
    elsif params[:sort] == "highly_rated"
      @books = @user.books.page(params[:page]).order(rate: :desc)
    elsif params[:sort] == "low_rating"
      @books = @user.books.page(params[:page]).order(rate: :asc)
    else
      @books = @user.books.page(params[:page]).order(created_at: :desc)
    end
  end

  def edit
    @user = User.find(params[:id])
    if @user == current_user
    else
      redirect_to user_path(current_user)
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user), notice: "プロフィールを更新しました"
    else
      render:edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

  def ensure_correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(current_user)
    end
  end
end
