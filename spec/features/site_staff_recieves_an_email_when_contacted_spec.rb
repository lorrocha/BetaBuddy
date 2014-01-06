require 'spec_helper'

feature 'When a contact is created, staff is notified via email', %q{
    As a site staff member
    I want to receive contact form inquiries via email
    So that I can see visitor feedback
} do
  # The dispatched email should come from the visitor's email address
  # The dispatched email should include the visitor's first and last name
  # The dispatched email should content description information submitted

  scenario 'An email is sent when a new contact is created' do
    ActionMailer::Base.deliveries = []
    visit new_contact_path

    name = 'Lawrence'
    lname = 'of Arabia'
    email = 'L@arabia.com'
    subject = 'Too much sand'
    desc = 'There is too much sand in my shoes. Help.'

    fill_in "First name", with: name
    fill_in "Last name", with: lname
    fill_in "Email", with: email
    fill_in "Subject", with: subject
    fill_in "Description", with: desc
    click_button "Submit Contact"

    expect(ActionMailer::Base.deliveries.count).to eql(1)
    last_email = ActionMailer::Base.deliveries.last
    expect(last_email).to have_subject(subject)
    expect(last_email).to have_body_text(email)
    expect(last_email).to have_body_text(name)
    expect(last_email).to have_body_text(lname)
    expect(last_email).to have_body_text(desc)
  end

end
