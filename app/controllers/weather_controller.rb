class WeatherController < ApplicationController
  def index
    # Do not send an API request if we don't have a proper param
    return unless santitized_search_param.present?

    response = connection.get('/search') { |req| req.params['name'] = santitized_search_param }
    JSON.parse(response.body)
  end

  private

  def connection
    @connection ||= Faraday.new(url: api_url, params: api_params, headers: api_headers) do |conn|
      conn.adapter Faraday.default_adapter
      conn.options.timeout = 5
    end
  end

  def api_url
    'https://geocoding-api.open-meteo.com/v1'
  end

  def api_params
    {
      count: 1,
      language: 'en',
      format: 'json'
    }
  end

  def api_headers
    { 'Content-Type' => 'application/json' }
  end

  def santitized_search_param
    return unless params[:search].present?

    str = params[:search].encode('UTF-8', invalid: :replace, undef: :replace, replace: '') # ensure good encoding
    str = str.gsub(/[\p{Cc}&&[^\n\t]]/, '').strip # remove control and \n\t characters
    str.gsub(/[<>|]/, '') # remove injection like characters
  end
end
