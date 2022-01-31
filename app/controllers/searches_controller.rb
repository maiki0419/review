class SearchesController < ApplicationController
  
  def search
    @word = params[:word]
    @range = params[:range]
  end
  
end
