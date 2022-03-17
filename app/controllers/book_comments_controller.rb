class BookCommentsController < ApplicationController

  def create
    book = Book.find(params[:book_id])
    comment = BookComment.new(book_comment_params)
    comment.user_id = current_user.id
    comment.book_id = book.id
    if comment.save
      redirect_to request.referer, notice: "コメントを投稿しました"
    else
      redirect_to request.referer, alert: "コメント投稿ができませんでした"
    end
  end

  def destroy
    BookComment.find(params[:id]).destroy
    redirect_to request.referer, notice: "コメントを削除しました"
  end
  
  private
  
  def book_comment_params
    params.require(:book_comment).permit(:comment)
  end

end
