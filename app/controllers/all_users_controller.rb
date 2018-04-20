class AllUsersController < ApplicationController
  def index
  	@curr=current_user.id
  	@users= User.where.not(id: @curr)
  end
end
