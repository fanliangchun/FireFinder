module AppsHelper
	def render_app_status(app)
		if app.is_hidden?
			content_tag(:span, "", class: "fa fa-lock")
		else
			content_tag(:span, "", class: "fa fa-globe")
		end
	end
end
