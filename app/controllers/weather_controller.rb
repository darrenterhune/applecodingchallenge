class WeatherController < ApplicationController
  def index
    lat_long = GeoLocation.new(params).call
    @weather = Weather.new(lat_long).call
    respond_to(&:turbo_stream)
  end
end
