class FavoritesController < ApplicationController
  before_action :authenticate_user!  #ログイン中のユーザーのみに許可（未ログインなら、ログイン画面へ
  def create
    @book = Book.find(params[:book_id])
    if @book.user_id != current_user.id #自分の投稿以外にお気に入り登録が可能
      @favorite = Favorite.create(user_id: current_user.id, book_id: @book.id)
    end
  end 
  
  
  def destroy
    @book = Book.find(params[:book_id])
    @favorite = Favorite.find_by(user_id: current_user.id, book_id: @book.id)
    @favorite.destroy
  end
end
