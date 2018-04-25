class FriendshipsController < ApplicationController
	before_action :authenticate_user!
	def index
		@friends=Friendship.where(friend_id: current_user.id, status: 'Pending').includes(:user)
	end
	
	def myfriends
		binding.pry
		@friends=current_user.inverse_friendships
		unless @friends.present?
			@friends = current_user.friendships
		end
		# @friends=Friendship.where('( user_id != ?) and status=?',current_user,"Accepted")		
	end
	def create	
		# binding.pry
		@user = User.find(current_user.id)
		@friend = User.find(params[:friend_id])
		# @t=Friendship.where(user_id: @user , friend_id: @friend).exists?
		 @t = Friendship.where('( user_id = ? and friend_id =? ) or (friend_id = ? and user_id=?)',@user,@friend,@user,@friend).exists?		
		if @t == true
			redirect_to root_path
		else
			
			@friendship = current_user.friendships.build(:friend_id => params[:friend_id],:status => "Pending")
			if @friendship.save				
				flash[:notice] = "Added friend."
				redirect_to all_users_index_path
			else
				flash[:error] = "Error occurred when adding friend."
				redirect_to all_users_index_path
			end
		end
	end
	def update
		binding.pry
		@friendship = current_user.friendships.build(:friend_id => params[:friend_id],:status => "Accepted")
		if @friendship.update
			redirect_to all_users_index_path
		else
			redirect_to all_users_index_path
		end
	end
	def destroy
		@curr=current_user.id
		@para=Friendship.where(user_id: params[:id],friend_id: @curr)
		@para.destroy(@para.ids)
		redirect_to friendrequests_path
	end

	def accept
		# binding.pry
		friendship = Friendship.find_by(user_id: params[:id])
		if friendship.present?
			friendship.update(status: 'Accepted')
			# current_user.friendships.create(:friend_id => params[:id],:status => "Accepted")
		else
			# alert[:message] = "Sorry Not found"
		end
		redirect_to friendships_path
		
	end

	def reject
		friendship = Friendship.find_by(id: params[:id])
		if friendship.present?
			friendship.update(status: 'Rejected')
		else
			# alert[:message] = "Sorry Not found"
		end
		redirect_to friendships_path
		
	end
end





