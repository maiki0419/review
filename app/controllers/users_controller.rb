class UsersController < ApplicationController
  before_action :ensure_correct_user, only: [:edit,:update]

  def show
    @user = User.find(params[:id])
    @books = @user.books
    @book = Book.new
    @current_userEntry = Entry.where(user_id: current_user.id)
    @userEntry = Entry.where(user_id: @user.id)

    if @user.id == current_user.id
    else
      @current_userEntry.each do |cu|
        @userEntry.each do |u|

          if cu.room_id == u.room_id
            @isroom = true
            @roomid = u.room_id
          end

        end
      end
      if @isroom
      else
        @room = Room.new
        @entry = Entry.new
      end
    end
# 7b
    # @create_today = @user.books.create_today
    # @create_yesterday = @user.books.create_yesterday
    # @ratio = @create_today.count/@create_yesterday.count.to_f
    # @create_thisweek = @user.books.create_thisweek
    # @create_lastweek = @user.books.create_lastweek
    # @week_ratio = @create_thisweek.count/@create_lastweek.count.to_f

    @create_today = @user.books.create_today
    @create_1day =@user.books.create_1day
    @create_2day =@user.books.create_2day
    @create_3day =@user.books.create_3day
   @create_4day =@user.books.create_4day
    @create_5day =@user.books.create_5day
    @create_6day =@user.books.create_6day




  end

  def index
    @users = User.all
    @book = Book.new
  end

  def followers
    @user = User.find(params[:id])
    @followers = @user.followers
  end

  def followeds
    @user =User.find(params[:id])
    @followeds = @user.followeds
  end



  def edit
    @user = User.find(params[:id])
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user.id), notice: "You have updated user successfully."
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

  def ensure_correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(current_user)
    end
  end
end
