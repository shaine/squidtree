module NavigationHelpers
  # Maps a name to a path. Used by the
  #
  #   When /^I go to (.+)$/ do |page_name|
  #
  # step definition in web_steps.rb
  #
  def path_to(page_name)
    case page_name

    when /the home\s?page/
      "/"
    when /the blog/
      "/blog/"
    when /the portfolio page/
      "/portfolio/"
    when /the about page/
      "/about/"
    when /the contact page/
      "/contact/"
    when /the login page/
      "/login/"
    when /the logout page/
      "/logout/"
    when /the discoveries page/
      "/links/"
    when /the user admin page/
      "/users/"
    when /a bad URL/
      "/foo/bar/baz"
    else
      raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
        "Now, go and add a mapping in #{__FILE__}"
    end
  end
end

World(NavigationHelpers)
