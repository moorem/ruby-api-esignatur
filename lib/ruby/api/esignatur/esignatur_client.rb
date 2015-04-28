require 'faraday'
require 'json'

API_URL = "https://api.esignatur.dk"

module Esignatur

  class APIClient
    
    def initialize(headers)
      @headers = headers
      @connection = set_connection
    end
    
    
    def create_order options = {}
      response = @connection.post do |req|
        req.url '/Order/Pending'
        req.headers.merge!(@headers)
        req.body = {Email: email}.to_json
      end
      JSON.parse(response.body)
    end
    
    
    def pending_orders email
      response = @connection.post do |req|
        req.url '/Order/Pending'
        req.headers.merge!(@headers)
        req.body = {Email: email}.to_json
      end
      JSON.parse(response.body)
    end
    
    def order_status email, order_no
      response = @connection.get do |req|
        req.url URI.encode('/Status/Get/{'+order_no+'}')
        req.headers.merge!(@headers)
        req.body = {Email: email}.to_json
      end
      JSON.parse(response.body)
    end
    
    def get_document options = {}
      response = @connection.post do |req|
        req.url URI.encode('/Pades/Download')
        req.headers.merge!(@headers)
        req.body = options.to_json
      end
      JSON.parse(response.body)
    end


    private
        
    def set_connection
      Faraday.new(:url => API_URL) do |faraday|
        faraday.request  :url_encoded
        faraday.response :logger
        faraday.adapter  Faraday.default_adapter
      end
    end
    
  end

end