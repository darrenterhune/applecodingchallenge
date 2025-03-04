require 'rails_helper'

RSpec.describe WeatherHelper, type: :helper do
  describe '#geocode_options_for_select_from' do
    context 'when geocodes is an empty array or nil' do
      it 'returns an empty array for nil' do
        expect(geocode_options_for_select_from(nil)).to eq([])
      end

      it 'returns an empty.stdin array for an empty array' do
        expect(geocode_options_for_select_from([])).to eq([])
      end
    end

    context 'when geocodes contains valid data' do
      let(:geocodes) do
        [
          {
            'name' => 'Parksville',
            'latitude' => 49.31947,
            'longitude' => -124.31575,
            'admin1' => 'British Columbia',
            'country' => 'Canada'
          },
          {
            'name' => 'Portland',
            'latitude' => 45.52345,
            'longitude' => -122.67621,
            'admin1' => 'Oregon',
            'country' => 'United States'
          }
        ]
      end

      it 'returns formatted options array' do
        expect(geocode_options_for_select_from(geocodes))
          .to(
            eq(
              [
                ['Parksville, British Columbia Canada', '49.31947,-124.31575'],
                ['Portland, Oregon United States', '45.52345,-122.67621']
              ]
            )
          )
      end
    end

    context 'when geocodes has missing fields' do
      let(:geocodes) do
        [
          { 'name' => 'Parksville', 'latitude' => 49.31947, 'longitude' => -124.31575 },
          { 'name' => 'Portland', 'latitude' => nil, 'longitude' => -122.67621, 'admin1' => 'Oregon' }
        ]
      end

      it 'handles missing fields gracefully' do
        expect(geocode_options_for_select_from(geocodes))
          .to(
            eq(
              [
                ['Parksville,  ', '49.31947,-124.31575'],
                ['Portland, Oregon ', ',-122.67621']
              ]
            )
          )
      end
    end
  end
end
