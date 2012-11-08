require 'test_helper'

class UsersMailerTest < ActionMailer::TestCase
  test "request_access" do
    mail = UsersMailer.request_access
    assert_equal "Request access", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
