class MessagesController < ApplicationController
  def index
    @message = Message.new
    @room = Room.find(params[:room_id])
    @messages = @room.messages.includes(:user)

    x = current_user.favorite_user_infos.pluck(:user_id)
    y = current_user.user_info.favorite_users.ids
    z = x & y
    @match = User.where(id: z)


    t = @room.room_users.where.not(user_id: current_user.id).pluck(:user_id)
    @honnin = User.find_by(id: t)

    # w = @room.room_users.where.not(user_id: current_user.id).pluck(:user_id)
    # @e = User.find(w)
    
    # current_user.rooms.each do |room|
      # t = room.room_users.where.not(user_id: current_user.id)
      # @chat_user = User.find(t)
      # @chat_u = User.find(1)
      # @chat_user.nickname
      # @chat_u.nickname
      # h = t.user_id
      # binding.pry
    # end
    
  end

  def create
    @room = Room.find(params[:room_id])
    @message = @room.messages.new(message_params)
    if @message.save
      redirect_to room_messages_path(@room)
    else
      @messages = @room.messages.includes(:user)
      render :index
    end

    # @room = Room.find(params[:room_id])
    # @message = @room.messages.create(content: params[:content], checked: false)
    # render json:{ post: message }
  end

  def preview
  end

  private

  def message_params
    params.require(:message).permit(:content).merge(user_id: current_user.id)
  end

  
end
