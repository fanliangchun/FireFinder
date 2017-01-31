module AppsHelper
	def render_app_status(app)
		if app.is_hidden?
			content_tag(:span, "", class: "fa fa-lock")
		else
			content_tag(:span, "", class: "fa fa-globe")
		end
	end

	def render_highlight_content(app,query_string)
    excerpt_cont = excerpt(app.title, query_string, radius: 500)
    highlight(excerpt_cont, query_string)
  end
end
