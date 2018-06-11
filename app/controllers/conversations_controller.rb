class ConversationsController < ApplicationController
	before_action :authenticate_user!

	def index
		@conversations=Conversation.all
	end
	def create
		@curr=current_user.id
		@other_user=User.find(params[:other_user])
		@conversation=Conversation.where('(sender_id = ? AND receiver_id = ? ) OR (sender_id = ? AND receiver_id = ? )', current_user.id, @other_user.id,  @other_user.id, current_user.id).present?
		if @conversation == true
			render :message
		else
			@conversation= Conversation.create(sender_id: current_user.id,receiver_id: @other_user.id)
			if @conversation.save
				render :message
			else
				redirect_to root_path
			end
		end
	end	
	def param_conv
		params.require(:conversation).permit(:sender_id,:receiver_id)
	end

	
end
# create(sender_id: current_user.id,receiver_id: @other_user.id)