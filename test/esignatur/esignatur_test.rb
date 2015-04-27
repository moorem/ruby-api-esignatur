require './test/test_helper'

class EsignaturTest < Minitest::Test

  def test_exists
    assert Esignatur::APIClient
  end

  def test_pending_orders
    VCR.use_cassette('pending_orders') do
      headers = set_headers
      client = Esignatur::APIClient.new(headers)
      result = client.pending_orders("info@kreditmatch.dk")
      assert_kind_of Hash, result
      assert_kind_of Array, result["PendingOrders"]
    end
  end

  def test_order_status
    VCR.use_cassette('order_status') do
      headers = set_headers
      client = Esignatur::APIClient.new(headers)
      result = client.order_status("info@kreditmatch.dk", "c00771af-359c-4628-a72d-185d20f4e608")
      assert_kind_of Hash, result
    end
  end
  
  def test_download_document
    VCR.use_cassette('get_document') do
      headers = set_headers
      client = Esignatur::APIClient.new(headers)
      result = client.get_document(Id: "34e6100f-51fa-4599-ae70-eda5385dc166", DocumentIndex: 0)
      assert_kind_of Hash, result
    end
  end
  
  
  private
  
  def set_headers
    {'Content-Type' => 'application/json',
     'X-Esignatur-Id' => '1aa6f55d-5724-e411-899d-d89d67640044'}
  end

end