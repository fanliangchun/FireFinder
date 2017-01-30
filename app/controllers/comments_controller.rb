class CommentsController < ApplicationController
	before_action :authenticate_user!, :only => [:new, :create, :edit, :update, :destroy]
	def new
		@app = App.find(params[:app_id])
		@comment = Comment.new
	end

	def create
		@app = App.find(params[:app_id])
		@comment = Comment.new(comment_params)
		@comment.app = @app
		@comment.user = current_user

		if @comment.save
			redirect_to app_path(@app)
		else
			render :new
		end
	end

	def edit
		@app = App.find(params[:app_id])
		@comment = Comment.find_by(user_id: params[:id])
	end

	def update
		@app = App.find(params[:app_id])
		@comment = Comment.find_by(user_id: params[:id])

		if @comment.update(comment_params)
			redirect_to app_path(@app)
		else
			render :edit
		end
	end

	def destroy
		@app = App.find(params[:app_id])
		@comment = Comment.find(parmas[:id])

		@comment.destroy
		redirect_to app_path(@app)
	end

	private

	def comment_params
		params.require(:comment).permit(:content)
	end
end
