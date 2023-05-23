require_relative '../countries'
require 'spec_helper'
require 'httparty'
require 'json'

describe Countries do
  describe '.fetch_data' do
    context 'when the API responds successfully' do
      before do
        stub_request(:get, 'https://restcountries.com/v3.1/subregion/Northern%20Europe')
          .to_return(status: 200, body: File.read('spec/fixtures/countries.json'), headers: {})
      end

      it 'hits the correct API endpoint' do
        Countries.fetch_data
        expect(a_request(:get, 'https://restcountries.com/v3.1/subregion/Northern%20Europe')).to have_been_made.once
      end

      it 'receives a successful response' do
        response = Countries.fetch_data
        expect(response.code).to eq(200)
      end

      it 'returns an array of countries' do
        response = Countries.fetch_data
        response_array = JSON.parse(response.parsed_response)
        expect(response_array).to be_an(Array)
      end

      it 'countries have the expected keys' do
        response = Countries.fetch_data
        response_array = JSON.parse(response.parsed_response)
        expect(response_array.first).to include("name", "population", "flags", "languages", "capital") 
      end
    end

    context 'when the API responds with an error' do
      before do
        stub_request(:get, 'https://restcountries.com/v3.1/subregion/Northern%20Europe').to_return(status: 500)
      end

      it 'raises a runtime error' do
        expect { Countries.fetch_data }.to raise_error(RuntimeError, 'API request failed')
      end
    end
  end

  describe '.transform_data' do
    let(:sample_response) { JSON.parse(File.read('spec/fixtures/countries.json')) }

    it 'returns an array' do
      transformed_data = Countries.transform_data(sample_response)
      expect(transformed_data).to be_an(Array)
    end

    it 'transforms the common name correctly' do
      transformed_data = Countries.transform_data(sample_response)
      expect(transformed_data.first[:name]).to eq('Guernsey')
    end

    it 'transforms the population correctly' do
      transformed_data = Countries.transform_data(sample_response)
      expect(transformed_data.first[:population]).to eq(62999)
    end

    it 'transforms the flags png correctly' do
      transformed_data = Countries.transform_data(sample_response)
      expect(transformed_data.first[:flags]).to eq('https://flagcdn.com/w320/gg.png')
    end

    it 'transforms the languages correctly' do
      transformed_data = Countries.transform_data(sample_response)
      expect(transformed_data.first[:languages]).to eq({
        "eng" => "English",
        "fra" => "French",
        "nfr" => "Guernésiais"
      })
    end

    it 'transforms the capital correctly' do
      transformed_data = Countries.transform_data(sample_response)
      expect(transformed_data.first[:capital]).to eq('St. Peter Port')
    end
  end
end