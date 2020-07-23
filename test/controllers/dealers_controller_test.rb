require 'test_helper'

class DealersControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get dealers_index_url
    assert_response :success
  end

  test "should get show" do
    get dealers_show_url
    assert_response :success
  end

end
