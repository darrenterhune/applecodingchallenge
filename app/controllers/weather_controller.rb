class WeatherController < ApplicationController
  def index
    @geocodes = GeoLocation.new(params).call
    @weather = Weather.new(params).call
    respond_to(&:turbo_stream)
  end
end
