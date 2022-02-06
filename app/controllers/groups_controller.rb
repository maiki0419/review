class GroupsController < ApplicationController
  before_action :correct_group, only: [:edit]

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    @group.owner_id = current_user.id
    if @group.save
      current_user.group_users.create(group_id: params[:id])
      redirect_to groups_path
    else
      render :new
    end
  end

  def join
    @group_user = current_user.group_users.create(group_id: params[:id])
    redirect_to request.referer
  end

  def out
    @group_user = current_user.group_users.find_by(group_id: params[:id])
    @group_user.destroy
    redirect_to request.referer
  end

  def index
    @groups = Group.all
     @user = User.find(current_user.id)
    @book = Book.new
  end

  def show
    @group = Group.find(params[:id])
    @user = User.find(current_user.id)
    @book = Book.new
    if current_user.group_users.find_by(group_id: @group.id).present?
      @isgroup = false
    else
      @isgroup = true
    end

  end

  def edit
    @group = Group.find(params[:id])
  end

  def update
    @group = Group.find(params[:id])
    if @group.update(group_params)
      redirect_to groups_path
    else
      render :edit
    end
  end

  private

  def group_params
    params.require(:group).permit(:name, :introduction, :image_id)
  end

  def correct_group
    @group = Group.find(params[:id])
    if @group.owner_id != current_user.id
      redirect_to user_path(current_user.id)
    end
  end

end
