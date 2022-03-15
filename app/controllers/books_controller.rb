class BooksController < ApplicationController
  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      redirect_to user_path(current_user), notice: "本の投稿ができました"
    else
      render:new
    end
  end

  def index
    @books = Book.all
  end

  def show
    @book = Book.find(params[:id])
    @book_comment = BookComment.new
  end

  def edit
    @book = Book.find(params[:id])
    if @book.user == current_user
    else
      redirect_to books_path
    end
  end

  def update
    @book = Book.find(params[:id])
    @user = @book.user
    if @book.update(book_params)
      redirect_to user_path(current_user), notice: "本のレビューを更新しました"
    else
      render:edit
    end
  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to request.referer, notice: "投稿を削除しました"
  end

  private
  # ストロングパラメータ
  def book_params
    params.require(:book).permit(:title, :body, :author, :genre, :book_image)
  end

end
