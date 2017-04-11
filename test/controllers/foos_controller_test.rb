require 'test_helper'

class FoosControllerTest < ActionDispatch::IntegrationTest
  test "should not get index if not authenticated" do
    get foos_url
    assert_redirected_to root_url
  end

  test "should get index if authenticated" do
    user = users(:one)
    sign_in_user user

    get foos_url
    assert_response :success
  end
end
