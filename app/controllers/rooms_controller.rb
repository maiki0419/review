class RoomsController < ApplicationController

  def create
    @room = Room.create
    @current_userEntry = current_user.entries.create(room_id: @room.id)
    @userEntry = Entry.create(entry_params.merge(room_id: @room.id))
    redirect_to room_path(@room.id)
  end

  def show

    @room = Room.find(params[:id])
    if Entry.where(user_id: current_user.id,room_id: @room.id)
      @message = Message.new
      @messages = @room.messages
      @entries = @room.entries
    else
     redirect_back(fallback_location: root_path)
   end

  end

  private

  def entry_params
    params.require(:entry).permit(:user_id, :room_id)
  end

end
