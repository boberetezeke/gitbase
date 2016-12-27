class Query
  attr_reader :params
  def initialize(params)
    @params = params
  end

  def offline?
    if Application.instance.respond_to?(:offline?)
      Application.instance.offline?
    else
      false
    end
  end

  def on_server?
    !(RUBY_ENGINE == 'opal')
  end

  def app_starting?
    Application.instance.app_starting?
  end

  def exists_locally?
    # Application.instance.exists_locally?(self)
    false
  end

  def execute_query_promise
    obj = execute_query
    Promise.new.resolve(obj)
  end

  def execute_http_promise
    execute_http
  end

  def url(url, params)
    # TODO: need to URI encode value
    url + "?" + params.map{|k, v| "#{k}=#{v}"}.join("&")
  end

  def run_locally
    puts "on server = #{on_server?}"
    if !on_server?
      puts "offline = #{offline?}, app starting = #{app_starting?}, exists locally = #{exists_locally?}"
    end

    result = on_server? || offline? || app_starting? || exists_locally?
    puts "result = #{result}"
    result
  end

  def query
    if run_locally
      execute_query_promise
    else
      execute_http
    end
  end
end

module Pages
  class PaginatedQuery < Query
    DEFAULT_PAGE = 1
    DEFAULT_PER_PAGE = 30

    def execute_query
      Page.limit(per_page).offset((page_number - 1) * per_page)
    end

    def execute_http(block)
      promise = Promise.new
      headers = {"Accept" => 'application/json', "content-Type" => 'application/json'}
      HTTP.get(url("/pages", page: page_number, per_page: per_page), headers: headers) do |resp|
        if resp.ok?
          pages = resp.json.map do |attrs|
            # TODO: use JSON parser to construct object graph
            Page.new(attrs)
          end

          promise.resolve(pages)
        else
          promise.reject(resp)
        end
      end
      promise
    end

    def per_page
      (params[:per_page] || DEFAULT_PER_PAGE).to_i
    end

    def page_number
      (params[:page] || DEFAULT_PAGE).to_i
    end
  end

  class PageQuery < Query
    def execute_query
      Page.find(params[:id])
    end

    def execute_http
      HTTP.get("/pages/#{params[:id]}")
    end
  end
end
