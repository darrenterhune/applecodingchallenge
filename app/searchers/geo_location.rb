# app/searchers/geo_location.rb

# This class is for retrieving lat/long coordinates from an API
# The base class has more info on the API
#
# - Attributes:
#   - @params: Hash, { search: "Ucluelet" }
# - Methods:
#   - #call: Send GET request to API to retrieve lat/long coordinates
#
# Example:
#
#   GeoLocation.new({ search: "Ucluelet" }).call
#
# =>
# {
#   latitude: 48.930725,
#   longitude: -125.53856
# }
#
class GeoLocation < Base
  def call
    return {} if santitized_search_param.blank?

    Rails.cache.fetch([:geocodes, santitized_search_param], expires_in: 30.minutes) do
      response['results']
    end
  end

  private

  def path
    '/v1/search'
  end

  def api_url
    'https://geocoding-api.open-meteo.com'
  end

  def api_params
    {
      count: 10,
      format: 'json',
      language: 'en',
      name: santitized_search_param
    }
  end

  def santitized_search_param
    # ensure proper encoding to avoid issues
    str = @params[:search].encode('UTF-8', invalid: :replace, undef: :replace, replace: '')
    # remove control and \n\t characters
    str = str.gsub(/[\p{Cc}&&[^\n\t]]/, '').strip
    # remove injection like characters
    str.gsub(/[<>|]/, '')
  end
end
