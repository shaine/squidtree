class ContactsMailer < ActionMailer::Base
  default from: "info@squidtree.com"
  default_url_options[:host] = "squidtree.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.contacts_mailer.contact.subject
  #
  def contact(contact)
    @contact = contact
    @subject = "Squidtree Contact"

    mail to: "shaine@squidtree.com", subject: @subject
  end
end
