class GeocodeController < ApplicationController
  def index
    @geocodes = GeoLocation.new(params).call
    respond_to(&:turbo_stream)
  end
end
