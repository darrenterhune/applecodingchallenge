# app/searchers/base.rb

# This class simply holds reusable code for different searcher objects
#
# - Attributes:
#   - @params: Hash, {}
#
class Base
  def initialize(params)
    @params = params
  end

  private

  def response
    @response ||= begin
      resp = connection.get(path)
      JSON.parse(resp.body)
    # For sake of time of a code challenge, I simply rescue from StandardError however this is not a good idea in
    # practice and I would never do this. Generally I would rescue from individual class object errors. Finding all
    # those is not trivial.
    rescue StandardError => e
      Rails.logger.error("Failed to retrieve data: #{e.message}")
      { results: [] }.as_json
    end
  end

  def connection
    @connection ||= Faraday.new(url: api_url, params: api_params, headers: api_headers)
  end

  def api_headers
    { 'Content-Type' => 'application/json' }
  end
end
