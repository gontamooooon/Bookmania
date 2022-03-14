class BookCommentsController < ApplicationController

  def create
    book = Book.find(params[:book_id])
    comment = BookComment.new(book_comment_params)
    comment.user_id = current_user.id
    comment.book_id = book.id
    comment.save
    redirect_to request.referer, notice: "コメントを投稿しました"
  end
  
  def destroy
    BookComment.find(params[:id]).destroy
    redirect_to request.referer, notice: "コメントを削除しました"
  end

  def book_comment_params
    params.require(:book_comment).permit(:comment)
  end

end
