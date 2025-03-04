# app/searchers/weather.rb

# This class is for retrieving a large amount of weather data from an API
# The base class has more info on the API
#
# - Attributes:
#   - @params: Hash { latlong: "48.930725,-125.53856" }
# - Methods:
#   - #call: Send GET request to API to retrieve weather data
#
# Example:
#
#   Weather.new({ latlong: "48.930725,-125.53856" }).call
#
# =>
# {
#   'latitude' => 48.930725,
#   'longitude' => -125.53856,
#   'generationtime_ms' => 0.247955322265625,
#   'utc_offset_seconds' => -28_800,
#   'timezone' => 'America/Los_Angeles',
#   'timezone_abbreviation' => 'GMT-8',
#   'elevation' => 34.0,
#   'current_units' => {
#     'time' => 'iso8601',
#     'interval' => 'seconds',
#     'temperature_2m' => '°C',
#     'precipitation' => 'mm',
#     'weather_code' => 'wmo code',
#     'wind_speed_10m' => 'km/h',
#     'wind_direction_10m' => '°',
#     'wind_gusts_10m' => 'km/h'
#   },
#   'current' => {
#     'time' => '2025-03-03T19:30',
#     'interval' => 900,
#     'temperature_2m' => 7.1,
#     'precipitation' => 0.0,
#     'weather_code' => 3,
#     'wind_speed_10m' => 10.3,
#     'wind_direction_10m' => 168,
#     'wind_gusts_10m' => 16.6
#   },
#   ...
# }
#
class Weather < Base
  def call
    return {} unless @params.present?

    Rails.cache.fetch([:weather, @params[:latlong]], expires_in: 30.minutes) do
      response
    end
  end

  private

  def latitude_longitude
    @params[:latlong].split(',')
  end

  def path
    '/v1/forecast'
  end

  def api_url
    'https://api.open-meteo.com'
  end

  def api_params
    {
      language: 'en',
      latitude: latitude_longitude[0],
      longitude: latitude_longitude[1],
      timezone: 'America/Los_Angeles',
      current: 'temperature_2m,precipitation,weather_code,wind_speed_10m,wind_direction_10m,wind_gusts_10m',
      hourly: 'wind_speed_80m,wind_direction_80m,temperature_80m',
      daily: 'temperature_2m_max,temperature_2m_min,precipitation_sum'
    }
  end
end
