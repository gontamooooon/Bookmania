class UsersController < ApplicationController
  before_action :ensure_correct_user, only: [:update]
  
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @books = @user.books
    # ログイン中のユーザーのお気に入りのbook_idカラムを取得
    favorites = Favorite.where(user_id: current_user.id).pluck(:book_id)
    # booksテーブルから、お気に入り登録済みのレコードを取得

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
