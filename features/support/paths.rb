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
      '/'
    when /the blog/
      '/blog/'
    when /the portfolio page/
      '/portfolio/'
    when /the about page/
      '/about/'
    when /the contact page/
      '/contact/'
    end
  end
end

World(NavigationHelpers)