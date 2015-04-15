require 'faraday'
require 'json'

API_URL = "https://api.esignatur.dk"

module Esignatur

  class Order
    
    def self.pending_orders email
      conn = Faraday.new(:url => API_URL) do |faraday|
        faraday.request  :url_encoded
        faraday.response :logger
        faraday.adapter  Faraday.default_adapter
      end
      
      response = conn.post do |req|
        req.url '/Order/Pending'
        req.headers['Content-Type'] = 'application/json'
        req.headers['X-Esignatur-Id'] = '1aa6f55d-5724-e411-899d-d89d67640044'
        req.body = "{ 'Email': '#{email}' }"
      end
      puts JSON.parse(response.body)["PendingOrders"]
    end
    
  end

end