# Test-Driven Development---HTTParty 

## Table of Contents

- [Introduction](#introduction)
- [Prerequisites](#prerequisites)
- [Getting Started](#getting-started)
- [Step-by-step Guide](#step-by-step-guide)
    - [Include Necessary Modules](#include-necessary-modules)
    - [Implement Fetch Data Function](#implement-fetch-data-function)
    - [Implement Transform Data Function](#implement-transform-data-function)
- [Testing Your Code](#testing-your-code)

## Introduction
This document provides detailed instructions on how to implement the `Countries` class in the `countries.rb` file so that all RSpec tests pass.

## Prerequisites
Ensure you have the required Ruby gems installed on your machine. If not, you can install them by running `bundle install` in your terminal from the root of this project.

## Getting Started
You will be implementing two class methods in the `Countries` class in `countries.rb`:

1. `fetch_data`: Sends a GET request to the endpoint 'https://restcountries.com/v3.1/subregion/Northern%20Europe' and returns the response.
2. `transform_data`: Accepts the response from the `fetch_data` function, parses the response body, and transforms the data into an array of hashes.

## Step-by-step Guide

### Include Necessary Modules
Before you begin, ensure to include the necessary modules by requiring them at the top of the `countries.rb` file. You will need `httparty` for this implementation.

### Implement Fetch Data Function
Create a class method named `fetch_data` inside the `Countries` class. This method should send a GET request to the provided endpoint and return the response. It should raise an error if the status code is not 200.
```console
def self.fetch_data
    # Your code here
end
```

### Implement Transform Data Function
Implement the `transform_data` function that takes in the response from the `fetch_data` function as an argument. The function should parse the response body and transform it into an array of hashes. Each hash should contain the keys: `name`, `population`, `flags`, `languages`, and `capital`.
```console
def self.transform_data(response)
    # Your code here
end
```

## Testing Your Code
After implementing the `fetch_data` and `transform_data` functions, you can check your work by running the provided RSpec tests.

To run the tests, open your terminal, navigate to the project directory, and enter the following command:
```console
rspec
```


If all tests pass, you've successfully completed the implementation. If any tests fail, review your code and the error messages for guidance on what needs to be fixed.
