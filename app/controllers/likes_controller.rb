class LikesController < ApplicationController
	before_action :authenticate_user!
	before_action :find_post,only:[:create]
	def create				
		@like = @post.likes.create(user_id: current_user.id)		
		if @like.save
			redirect_to post_path(@post)
		else 
			redirect_to post_path(@post)
		end
	end	
	def all_likes
		@post=Post.find(params[:format])	
		@likes=@post.liked_users
	end
	def find_post

		@post=Post.find(params[:post_id])
	end

end
