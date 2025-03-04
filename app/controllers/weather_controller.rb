class WeatherController < ApplicationController
  def index
    @response = GeoLocation.new(params).call
    respond_to(&:turbo_stream)
  end
end
