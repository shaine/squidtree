class UsersMailer < ActionMailer::Base
  default from: "info@squidtree.com"
  default_url_options[:host] = "squidtree.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.users.request_access.subject
  #
  def request_access(user, user_url)
    @user = user
    @user_url = user_url
    @subject = "Squidtree Access Request"

    mail to: "hatch@fadelight.com", subject: @subject
  end
end
