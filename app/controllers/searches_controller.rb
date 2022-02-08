class SearchesController < ApplicationController

  def search
    @word = params[:word]
    @range = params[:range]
    @search = params[:search]
    if @range == "User"
      @users = User.looks(@search,@word)
    else
      @books = Book.looks(@search,@word)
    end
  end
  
  def categorysearch
    @word = params[:word]
    @categories = Category.where(name: @word)
  end

end
