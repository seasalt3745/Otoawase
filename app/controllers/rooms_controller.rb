class RoomsController < ApplicationController

before_action :authenticate_user!

  def index
  end

  def create
  	@room = Room.create(:name => "")
    @entry1 = Entry.create(:room_id => @room.id, :user_id => current_user.id)#自分の分
    @entry2 = Entry.create(params.require(:entry).permit(:user_id, :room_id).merge(:room_id => @room.id))#相手の分
    redirect_to room_path(@room.id)
  end

  def show
  	@room = Room.find(params[:id])
    #present?の戻り値は真偽値。よって、trueの場合、
    if Entry.where(:user_id => current_user.id, :room_id => @room.id).present?
      @messages = @room.messages
      @entries = @room.entries
    else
      redirect_back(fallback_location: root_path)
    end
  end

end
