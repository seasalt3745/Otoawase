class RoomChannel < ApplicationCable::Channel
  def subscribed
    # stream_from "some_channel"
    # pp params['room']
     stream_from "room_channel_#{params['room']}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def speak(data)
    # pp data
  	Message.create! message: data['message'], user_id: current_user.id, room_id: params['room']
  end
end
