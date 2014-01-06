require 'spec_helper'

feature 'A visitor to the site can submit a contact form', %q{
    As a site visitor
    I want to contact the site's staff
    So that I can ask questions or make comments about the site
} do
  # I must specify a valid email address
  # I must specify a subject
  # I must specify a description
  # I must specify a first name
  # I must specify a last name

  scenario 'A user can submit a valid contact inquiry' do
    visit '/contact'

    fill_in "First name", with: 'Lawrence'
    fill_in "Last name", with: 'of Arabia'
    fill_in "Email", with: 'L@arabia.com'
    fill_in "Subject", with: 'Too much sand'
    fill_in "Description", with: 'There is too much sand in my shoes. Help.'
    click_button "Submit Contact"

    expect(page).to have_content('Your contact has been submitted! You should hear back shortly.')
  end
end
