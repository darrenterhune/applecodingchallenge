require 'rails_helper'

RSpec.describe GeoLocation do
  let(:instance) { described_class.new({ search: 'Ucluelet' }) }

  describe '#initialize' do
    it 'sets the name' do
      expect(instance.instance_variable_get(:@params)).to eq({ search: 'Ucluelet' })
    end
  end

  describe '#call' do
    let(:successful_response) { { results: [{ 'latitude' => 48.9333, 'longitude' => 125.0500 }] }.as_json }
    let(:error_response) { { results: [] }.as_json }

    before do
      allow(instance).to receive(:response).and_return(successful_response)
    end

    it 'returns latitude and longitude when no error' do
      expect(instance.call).to eq([{"latitude"=>48.9333, "longitude"=>125.05}])
    end

    it 'returns the error response when there is an error' do
      allow(instance).to receive(:response).and_return(error_response)
      expect(instance.call).to eq([])
    end
  end
end
