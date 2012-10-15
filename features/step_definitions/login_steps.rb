Given /^I am signed in with provider "([^"]*)"(?:| as ([.+]))?$/ do |provider, user|
  OmniAuth.config.test_mode = true

  case provider
  when "Facebook"
    OmniAuth.config.mock_auth[:facebook] = {
      "provider"  => "facebook",
      "uid"       => '12345',
      "info" => {
        "email" => "testadmin@squidtree.com",
        "first_name" => "Admin",
        "last_name" => "Test",
      }
    }

    case user
    when "an admin"
      OmniAuth.config.mock_auth[:facebook][:user_info] = {"email"=>"", "first_name"=>"Admin", "last_name"=>"Test", "name"=>"Admin Test"}
    else # Or a user
      OmniAuth.config.mock_auth[:facebook][:user_info] = {"email"=>"user1@digitaltrike.com", "first_name"=>"User", "last_name"=>"First", "name"=>"User First"}
    end
  else
    raise "Provider #{provider} has not been configured."
  end

  visit "/auth/#{provider.downcase}_apps"
end


