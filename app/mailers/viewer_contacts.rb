class ViewerContacts < ActionMailer::Base
  @staff = 'sorai120@yahoo.com'

  default from: "from@example.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.viewer_contacts.contact.subject
  #
  def contact(form)
    @contact = form

    mail to: 'sorai120@yahoo.com',
      subject: @contact.subject

  end
end
