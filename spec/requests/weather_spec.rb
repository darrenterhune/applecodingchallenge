require 'rails_helper'

RSpec.describe 'Weather', type: :request do
  describe 'POST /weather' do
    it 'returns http success without data' do
      params = { search: '', latlong: '48.930725,-125.53856' }

      post '/weather', params:, as: :turbo_stream

      expect(response).to have_http_status(:success)
      expect(response).to have_http_status(:success)
      expect(response.media_type).to eq Mime[:turbo_stream]
      expect(response.body).to include('<turbo-stream action="update" target="search_results">')
      expect(response.body).to include("We couldn't find any data")
    end

    it 'returns http success with data' do
      params = { search: 'Ucluelet', latlong: '48.930725,-125.53856' }

      post '/weather', params:, as: :turbo_stream

      expect(response).to have_http_status(:success)
      expect(response).to have_http_status(:success)
      expect(response.media_type).to eq Mime[:turbo_stream]
      expect(response.body).to include('<turbo-stream action="update" target="search_results">')
      expect(response.body).to include('Weather for Latitude')
    end
  end
end
