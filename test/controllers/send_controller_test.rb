require 'test_helper'

class SendControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get send_create_url
    assert_response :success
  end

end
