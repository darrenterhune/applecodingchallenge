require 'rails_helper'

RSpec.describe 'Weathers', type: :request do
  describe 'POST /weather' do
    it 'returns http success' do
      post '/weather', as: :turbo_stream

      expect(response).to have_http_status(:success)
      expect(response).to have_http_status(:success)
      expect(response.media_type).to eq Mime[:turbo_stream]
      expect(response.body).to include('<turbo-stream action="replace" target="search_results">')
    end
  end
end
