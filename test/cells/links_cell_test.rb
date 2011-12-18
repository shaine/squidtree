require 'test_helper'

class LinksCellTest < Cell::TestCase
  test "index" do
    invoke :index
    assert_select "p"
  end
  

end
