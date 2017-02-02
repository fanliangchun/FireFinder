class AppsController < ApplicationController
	before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
	before_action :find_app, only: [:show, :edit, :update, :destroy, :upvote]
	before_action :validate_search_key, only: [:search]

	def index
		if params[:category].blank?
			@apps = App.published.recent.paginate(:page => params[:page], :per_page => 9)
		else
			@category_id = Category.find_by(name: params[:category]).id
			@apps = App.where(:category_id => @category_id).recent.paginate(:page => params[:page], :per_page => 9)
		end
	end

	def show

		@comments = @app.comments
		if @app.is_hidden
			flash[:warning] = "This app is already archieved."
			redirect_to '/'
		end
	end

	def new
		@app = App.new
		@categories = Category.all.map { |c| [c.name, c.id] }
	end

	def create
		@app = App.new(app_params)
		@app.user = current_user
		@app.category_id = params[:category_id]

		if @app.save
			redirect_to apps_path
		else
			render :new
		end
	end

	def edit
		@categories = Category.all.map { |c| [c.name, c.id] }
	end

	def update
		@app.category_id = params[:category_id]
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

	def upvote
		@app.votes.create
		redirect_to :back
	end

	def search
    if @query_string.present?
      search_result = App.published.ransack(@search_criteria).result(:distinct => true)
      @apps = search_result.paginate(:page => params[:page], :per_page => 5 )
    end
  end


  protected

  def validate_search_key
    @query_string = params[:q].gsub(/\\|\'|\/|\?/, "") if params[:q].present?
    @search_criteria = search_criteria(@query_string)
  end


  def search_criteria(query_string)
    { :title_cont => query_string }
  end

	private

	def app_params
		params.require(:app).permit(:title, :description, :is_hidden, :image, :category_id)
	end

	def find_app
		@app = App.find(params[:id])
	end

end
