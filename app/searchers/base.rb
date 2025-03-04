class Base
  def initialize(params)
    @params = params
  end

  private

  def connection
    @connection ||= Faraday.new(url: api_url, params: api_params, headers: api_headers)
  end

  def api_headers
    { 'Content-Type' => 'application/json' }
  end
end
