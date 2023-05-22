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
    end
end