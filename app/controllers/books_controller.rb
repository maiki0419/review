class BooksController < ApplicationController
before_action :ensure_correct_user,only: [:edit]
  def show
    @book = Book.find(params[:id])
    @book_new = Book.new
    @category = @book_new.categories.new
    @user = @book.user
    @book_comment = BookComment.new
    @book_comments = @book.book_comments
    impressionist(@book, nil, unique: [:ip_address])
  end

  def index
    if params[:create]
      @books = Book.all.order(created_at: "DESC")
    elsif params[:rate]
      @books = Book.all.order(rate: "DESC")
    else
      @books = Book.created_1week.sort{|a,b| b.favorites.size <=> a.favorites.size}
    end
      @book = Book.new
     @category = @book.categories.new
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      redirect_to book_path(@book.id), notice: "You have created book successfully."
    else
      @books = Book.all
      render :index
    end
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book), notice: "You have updated book successfully."
    else
      render "edit"
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title,:body, :rate, categories_attributes: [:name, :_destroy])
  end

  def ensure_correct_user
    @book = Book.find(params[:id])
    unless @book.user.id == current_user.id
      redirect_to books_path
    end
  end
end
