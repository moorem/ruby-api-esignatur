require './test/test_helper'

class EsignaturTest < Minitest::Test
  def test_exists
    assert Esignatur::Order
  end
end