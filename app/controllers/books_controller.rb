class BooksController < ApplicationController
  before_action :authenticate_user!
  
  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    # Natural Language API
    @book.score = Language.get_data(book_params[:body])  #この行を追加
    @book.user_id = current_user.id
    if @book.save
      redirect_to user_path(current_user), notice: "本の投稿ができました"
    else
      render :new
    end
  end

  def index
    @books = Book.all
    # ソート機能
    if params[:sort] == "new_arrival_order"
      @books = Book.page(params[:page]).order(created_at: :desc)
    elsif params[:sort] == "posting_order"
      @books = Book.page(params[:page]).order(created_at: :asc)
    elsif params[:sort] == "highly_rated"
      @books = Book.page(params[:page]).order(rate: :desc)
    elsif params[:sort] == "low_rating"
      @books = Book.page(params[:page]).order(rate: :asc)
    else
      @books = Book.page(params[:page]).order(created_at: :desc)
    end
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
      render :edit
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
    params.require(:book).permit(:title, :body, :author, :genre, :book_image, :rate)
  end
end
