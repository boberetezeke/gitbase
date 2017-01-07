module Pages
  class PaginatedQuery < Query
    DEFAULT_PAGE = 1
    DEFAULT_PER_PAGE = 30

    def execute_query
      Page.limit(per_page).offset((page_number - 1) * per_page)
    end

    def execute_http(block)
      promise = Promise.new
      http_get(url("/pages", page: page_number, per_page: per_page)) do |json|
        json.map do |attrs|
          Page.new(attrs)
        end
      end
    end

    def per_page
      (params[:per_page] || DEFAULT_PER_PAGE).to_i
    end

    def page_number
      (params[:page] || DEFAULT_PAGE).to_i
    end
  end
end
