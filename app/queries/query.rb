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
    promise = Promise.new

    if on_server?
      promise.resolve(obj)
    else
      # prevent rentrancy issues
      # after(0) { promise.resolve(obj) }
      promise.resolve(obj)
    end

    promise
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

  def http_get(url)
    promise = Promise.new
    headers = {"Accept" => 'application/json', "content-Type" => 'application/json'}
    puts "http_get: getting from: #{url}"
    HTTP.get(url, headers: headers) do |resp|
      if resp.ok?
        puts "http_get: ok response: #{resp.json}"
        promise.resolve(yield(resp.json))
      else
        puts "http_get: error"
        promise.reject(resp)
      end
    end

    promise
  end

  def query
    if run_locally
      execute_query_promise
    else
      execute_http
    end
  end
end
