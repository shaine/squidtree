Before('@omniauth_test_success') do
  OmniAuth.config.test_mode = true

  OmniAuth.config.mock_auth[:facebook] = {
    "provider"  => "facebook",
    "uid"       => '12345',
    "info" => {
      "email" => "testadmin@squidtree.com",
      "first_name" => "Admin",
      "last_name" => "Test",
    }
  }
end

Before('@omniauth_test_failure') do
  OmniAuth.config.test_mode = true
  OmniAuth.config.mock_auth[:facebook] = :invalid_credentials
end
