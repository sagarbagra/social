class PostsController < ApplicationController
	before_action :authenticate_user!
	before_action :find_comment,only:[:destroy]
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
	def comment
		@post=Post.find(params[:id])
		@comment=@post.comments.new(comment: params[:comment],user_id: current_user.id )
		if @comment.save
			redirect_to post_path(@post)
		else 
			redirect_to post_path(@post)
		end
	end
	def remove_comment
		 @post = Post.find_by(id: params[:id])
		@comment  = @post .comments.find_by(id: params[:comment])
	 	if @comment.destroy
			redirect_to post_path(@post)
		else
			redirect_to post_path(@post)
		end
	end 

	def like
		# binding.pry
		@post=Post.find(params[:id])
		@like = @post.likes.new(user_id: current_user.id, like: "liked")		
		if @like.save
			redirect_to post_path(@post)
		else 
			redirect_to post_path(@post)
		end
		
	end
	def all_likes
		# binding.pry
		@post=Post.find(params[:id])	
		@likes=@post.liked_users
	end
	def user_profile
	end

	def unlike
		@post=Post.find(params[:id])
		@like = @post.likes.where(user_id: current_user.id, like: "liked")		
		if @like.present?
			@like.destroy_all
			redirect_to post_path(@post)
		else 
			redirect_to post_path(@post)
		end		
	end
	def show		
		@post=Post.find(params[:id])
		@my_like = 	@post.likes.where(user_id: current_user.id)
		@comments=Comment.where(post_id: @post).order("created_at DESC")
	end
	def my_post
		@posts=current_user.posts.all
	end 

	def find_post
		# binding.pry
		@post=Post.find(params[:post_id])
	end
	def find_comment	
		@comment=@post.comments.find(params[:id])
	end

end
