module Pages
  class PageQuery < Query
    def execute_query
      Page.find(params[:id])
    end

    def execute_http
      http_get("/pages/#{params[:id]}") do |json|
        Page.new(json)
      end
    end
  end
end
