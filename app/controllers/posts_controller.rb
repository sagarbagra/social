class PostsController < ApplicationController
	before_action :authenticate_user!

	def index
		@posts=Post.all.order("created_at DESC").paginate(:page => params[:page],:per_page =>2)		
	end
	def new
		@post=current_user.posts.build
	end
	def create
		@post=current_user.posts.build(param_post)
		if @post.save!
			redirect_to posts_path  
		else
			render :new
		end
	end	
	def update

	end
	def destroy
		
	end
	def param_post
		params.require(:post).permit(:title,:image,:user_id)
	end
	def edit

	end
	def show		
		# binding.pry
		@post=Post.find(params[:id])
		@comments=Comment.where(post_id: @post).order("created_at DESC")
	end
	def my_post
		@posts=current_user.posts.all
	end 
end
