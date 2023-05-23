require 'pry'
require 'httparty'

class Countries
    # Your code here
    def self.fetch_data
        response = HTTParty.get('https://restcountries.com/v3.1/subregion/Northern%20Europe')
        raise 'API request failed' unless response.success?
        response
    end

    def self.transform_data(response)
        # Your code here
        response.map do |country|
            {
                name: country['name']['common'],
                population: country['population'],
                flags: country['flags']['png'],
                languages: country['languages'],
                capital: country['capital'][0]
            }
        end
    end
end