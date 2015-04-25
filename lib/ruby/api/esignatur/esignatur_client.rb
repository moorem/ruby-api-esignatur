require 'faraday'
require 'json'

API_URL = "https://api.esignatur.dk"

module Esignatur

  class APIClient
    
    def initialize(headers)
      @headers = headers
    end
    
    def pending_orders email
      connection = set_connection
      response = connection.post do |req|
        req.url '/Order/Pending'
        req.headers.merge!(@headers)
        req.body = "{ 'Email': '#{email}' }"
      end
      JSON.parse(response.body)
    end

    private
    
    def set_connection
      Faraday.new(:url => API_URL) do |faraday|
        faraday.request  :url_encoded
        #faraday.response :logger
        faraday.adapter  Faraday.default_adapter
      end
    end
    
  end

end