class BookCommentsController < ApplicationController

  def create
    @book = Book.find(params[:book_id])
    @book_comment = @book.book_comments.new(book_comment_params)
    @book_comment.user_id = current_user.id
    @book_comment.save
    @book_comments = @book.book_comments

  end

  def destroy
    @book = Book.find(params[:book_id])
    @book_comment = @book.book_comments.find_by(id: params[:id])
    @book_comment.destroy
    @book_comments = @book.book_comments
  end



  private

  def book_comment_params
    params.require(:book_comment).permit(:user_id, :book_id, :comment)
  end

end
