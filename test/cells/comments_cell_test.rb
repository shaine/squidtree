require 'test_helper'

class CommentsCellTest < Cell::TestCase
  test "index" do
    invoke :index
    assert_select "p"
  end
  

end
