module WeatherHelper
  def geocode_options_for_select_from(geocodes)
    data = geocodes.as_json(only: %w[name latitude longitude admin1 country]) || {}
    data.map { |g| ["#{g['name']}, #{g['admin1']} #{g['country']}", "#{g['latitude']},#{g['longitude']}"] }
  end
end
