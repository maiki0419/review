class BookCommentsController < ApplicationController

  def create
    @book = Book.find(params[:book_id])
    @book_comment = @book.book_comments.new(book_comment_params)
    @book_comment.user_id = current_user.id
    if @book_comment.save
      redirect_to request.referer
    else
      redirect_to request.referer
    end
  end

  def destroy
    @book = Book.find(params[:book_id])
    @book_comment = @book.book_comments.find_by(id: params[:id])
    @book_comment.destroy
    redirect_to request.referer
  end



  private

  def book_comment_params
    params.require(:book_comment).permit(:user_id, :book_id, :comment)
  end

end
