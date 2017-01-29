class AppsController < ApplicationController
	before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
	before_action :find_app, only: [:show, :edit, :update, :destroy]

	def index
		@apps = App.all
	end

	def show
	end

	def new
		@app = App.new
	end

	def create
		@app = App.new(app_params)

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
		params.require(:app).permit(:title, :description)
	end

	def find_app
		@app = App.find(params[:id])
	end

end
