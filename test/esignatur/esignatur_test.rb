require './test/test_helper'

class EsignaturTest < Minitest::Test
  def test_exists
    assert Esignatur::Order
  end
  
  def test_it_gives_back_pending_orders
    VCR.use_cassette('pending_orders') do
      orders = Esignatur::Order.pending_orders("test@noemail.com")
    end
  end
  
end