require 'rails_helper'

RSpec.describe Weather do
  let(:instance) { described_class.new({ latitude: 48.9333, longitude: 125.0500 }) }

  describe '#initialize' do
    it 'sets the name' do
      expect(instance.instance_variable_get(:@params)).to eq({ latitude: 48.9333, longitude: 125.0500 })
    end
  end

  describe '#call' do
    let(:successful_response) do
      {
        latitude: 48.930725,
        longitude: -125.53856,
        generationtime_ms: 5.790829658508301,
        utc_offset_seconds: -28_800,
        timezone: 'America/Los_Angeles',
        timezone_abbreviation: 'GMT-8',
        elevation: 21.0
      }.as_json
    end
    let(:error_response) { { error: true }.as_json }

    before do
      allow(instance).to receive(:response).and_return(successful_response)
    end

    it 'returns data when no error' do
      expect(instance.call).to eq(successful_response)
    end

    it 'returns the error response when there is an error' do
      allow(instance).to receive(:response).and_return(error_response)
      expect(instance.call).to eq('error' => true)
    end
  end
end
