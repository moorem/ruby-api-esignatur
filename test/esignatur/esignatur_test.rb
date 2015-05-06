require './test/test_helper'

class EsignaturTest < Minitest::Test

  def test_exists
    assert Esignatur::APIClient
  end
  
  def test_create_order
    VCR.use_cassette('create_order') do
      headers = set_headers
      client = Esignatur::APIClient.new(headers)
      pdf_encoded = File.read("pdf_base64.txt")

      signing_body = {CreatorId: "9208-2002-2-315851760650",
         SenderEmail: "info@kreditmatch.dk",
         CommonNote: "This is a test order for signing.",
         EndDate: Time.now,
         Documents: [
           {
             title: "Signing Contract",
             Filename: "contract.pdf",
             DocumentFormat: "Pdf",
             DocumentData: pdf_encoded
           }
         ],
         steps: [
           {
             Signers: [
               {
                 name: 'Name1',
                 email: 'developer@moorem.com',
                 identification: '23434234234234'
               }
             ]
           },
           {
             Signers: [
               {
                 name: 'Name2',
                 email: 'ankur@moorem.com',
                 identification: '23434234234234'
               }
             ]
           }
         ]
      }

      result = client.create_order(signing_body)
      assert_kind_of Hash, result
    end
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
  
  def test_validate_pdf_document
    VCR.use_cassette('validate_pdf_document') do
      headers = set_headers
      client = Esignatur::APIClient.new(headers)
      pdf_encoded = File.read("pdf_base64.txt")
      result = client.validate_document(DocumentData: pdf_encoded)
      assert_kind_of Hash, result
      assert_equal result, {"Status"=>"Ok", "Errors"=>""}
    end
  end
  
  private
  
  def set_headers
    {'Content-Type' => 'application/json',
     'X-Esignatur-Id' => '1aa6f55d-5724-e411-899d-d89d67640044'}
  end

end