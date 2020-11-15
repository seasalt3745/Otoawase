class UsersController < ApplicationController

before_action :ensure_correct_user, only: [:edit, :update, :hide, :withdrawal]

	def top
		@instruments = Instrument.all
		@genres = Genre.all
	end

	def about
	end

	def index
		@users = User.all
	end

	def show
		@user = User.find(params[:id])
	    @currentUserEntry = Entry.where(user_id: current_user.id)
	    @userEntry=Entry.where(user_id: @user.id)
	    unless @user.id == current_user.id
	      @currentUserEntry.each do |cu|
	        @userEntry.each do |u|
	          if cu.room_id == u.room_id then
	            @isRoom = true
	            @roomId = cu.room_id
	          end
	        end
	      end

	      unless @isRoom
	        @room = Room.new
	        @entry = Entry.new
	      end
	    end
	end

	def edit
	end

	def update
		if @user.update(user_params)
	      redirect_to user_path(@user), notice: "You have updated user successfully."
	    else
	      render "edit"
	    end
	end

	def hide
	end

	def withdrawal
        @user.update(is_deleted: true)
        reset_session
        redirect_to root_path
	end


	private

    def user_params
      params.require(:user).permit(:email, :name, :password, :password_confirmation, :image, :area, :experience, :stance, :history, :introduction, :is_deleted)
    end

    def ensure_correct_user
      @user = User.find(params[:id])
      unless @user == current_user
        redirect_to user_path(current_user)
      end
    end

end
