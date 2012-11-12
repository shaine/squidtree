Given /^I am signed in with provider "(.*?)"(?: as (.*?))?$/ do |provider, user|
  OmniAuth.config.test_mode = true

  case provider
  when "Facebook"
    OmniAuth.config.mock_auth[:facebook] = {
      "provider"  => "facebook",
    }

    case user
    when "Admin Test"
      OmniAuth.config.mock_auth[:facebook]["uid"] = 123451
      OmniAuth.config.mock_auth[:facebook][:info] =
        {
          "email" => "admin@squidtree.com",
          "first_name" => "Admin",
          "last_name" => "Test",
          "name" => "Admin Test",
          "nickname" => "admin",
          "urls" => {
            "Facebook" => "http://facebook.com"
          }
        }
    when "Editor Test"
      OmniAuth.config.mock_auth[:facebook]["uid"] = 123452
      OmniAuth.config.mock_auth[:facebook][:info] =
        {
          "email" => "editor@squidtree.com",
          "first_name" => "Editor",
          "last_name" => "Test",
          "name" => "Editor Test",
          "nickname" => "editor",
          "urls" => {
            "Facebook" => "http://facebook.com"
          }
        }
    when "Whitelisted Test"
      OmniAuth.config.mock_auth[:facebook]["uid"] = 123453
      OmniAuth.config.mock_auth[:facebook][:info] =
        {
          "email" => "whitelisted@squidtree.com",
          "first_name" => "Whitelisted",
          "last_name" => "Test",
          "name" => "Whitelisted Test",
          "nickname" => "white",
          "urls" => {
            "Facebook" => "http://facebook.com"
          }
        }
    else # Or a user
      OmniAuth.config.mock_auth[:facebook]["uid"] = 123454
      OmniAuth.config.mock_auth[:facebook][:info] =
        {
          "email" => "anonymous@squidtree.com",
          "first_name" => "Anonymous",
          "last_name" => "Test",
          "name" => "Anonymous Test",
          "nickname" => "anon",
          "urls" => {
            "Facebook" => "http://facebook.com"
          }
        }
    end
  else
    raise "Provider #{provider} has not been configured."
  end

  visit "/auth/#{provider.downcase}"
end

Given /I am logged out/ do
  visit path_to("the logout page")
end


