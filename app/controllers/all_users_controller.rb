class AllUsersController < ApplicationController
  def index
  	# binding.pry
  	@curr=current_user.id
  	@users= User.where.not(id: @curr)
  	# @users=Friendship.where.not(user_id: @curr,status: "Accepted")
  end
end
