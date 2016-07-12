require 'test_helper'

class FeedsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get feeds_new_url
    assert_response :success
  end

end
