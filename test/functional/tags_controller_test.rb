require 'test_helper'

class TagsControllerTest < ActionController::TestCase
  test "should get view" do
    get :view
    assert_response :success
  end

end
