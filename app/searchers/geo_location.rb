class GeoLocation < Base
  def call
    return response if response['error']

    { latitude:, longitude: }
  end

  private

  def latitude
    response['results'][0]['latitude']
  end

  def longitude
    response['results'][0]['longitude']
  end

  def response
    @response ||= begin
      response = connection.get('/v1/search') { |req| req.params['name'] = santitized_search_param }
      JSON.parse(response.body)
    # For sake of time of a code challenge, I simply rescue from StandardError however this is not a good idea in
    # practice and I would never do this. Generally I would rescue from individual class object errors
    rescue StandardError => e
      { msg: "Failed to retrieve data: #{e.message}", error: true }
    end
  end

  def api_url
    'https://geocoding-api.open-meteo.com'
  end

  def api_params
    {
      count: 1,
      language: 'en',
      format: 'json'
    }
  end

  def santitized_search_param
    return unless @params.present?

    # ensure proper encoding to avoid issues
    str = @params[:search].encode('UTF-8', invalid: :replace, undef: :replace, replace: '')
    # remove control and \n\t characters
    str = str.gsub(/[\p{Cc}&&[^\n\t]]/, '').strip
    # remove injection like characters
    str.gsub(/[<>|]/, '')
  end
end
