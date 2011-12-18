require 'test_helper'

class PostsCellTest < Cell::TestCase
  test "index" do
    invoke :index
    assert_select "p"
  end
  

end
