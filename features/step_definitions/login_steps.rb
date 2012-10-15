Given /^I am signed in with provider "([^"]*)"(?:| as ([.+]))?$/ do |provider, user|
  OmniAuth.config.test_mode = true

  OmniAuth.config.mock_auth[:google] = {
    "provider"=>"google",
    "uid"=>"http://digitaltrike.com/openid?id=112298941776999335504"
  }

  case user
  when "an admin"
    OmniAuth.config.mock_auth[:google][:user_info] = {"email"=>"admin@digitaltrike.com", "first_name"=>"Admin", "last_name"=>"Test", "name"=>"Admin Test"}
  when "a manager"
    OmniAuth.config.mock_auth[:google][:user_info] = {"email"=>"manager@digitaltrike.com", "first_name"=>"Manager", "last_name"=>"Test", "name"=>"Manager Test"}
  else # Or a user
    OmniAuth.config.mock_auth[:google][:user_info] = {"email"=>"user1@digitaltrike.com", "first_name"=>"User", "last_name"=>"First", "name"=>"User First"}
  end

  visit "/auth/#{provider.downcase}_apps"
end


