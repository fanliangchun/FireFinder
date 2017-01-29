class AppsController < ApplicationController
	before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
	before_action :find_app, only: [:show, :edit, :update, :destroy]

	def index
		@apps = App.where(is_hidden: false).order("created_at DESC")
	end

	def show
		if @app.is_hidden
			flash[:warning] = "This app is already archieved."
			redirect_to '/'
		end
	end

	def new
		@app = App.new
	end

	def create
		@app = App.new(app_params)
		@app.user = current_user

		if @app.save
			redirect_to apps_path
		else
			render :new
		end
	end

	def edit
	end

	def update
		if @app.update(app_params)
			redirect_to apps_path, notice: "App Updated"
		else
			render :edit
		end
	end

	def destroy
		@app.destroy
		redirect_to apps_path, alert: "App Deleted"
	end

	private

	def app_params
		params.require(:app).permit(:title, :description, :is_hidden)
	end

	def find_app
		@app = App.find(params[:id])
	end

end
