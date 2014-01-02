require 'spec_helper'

feature "A viewer can register to authenticate", %{
  As a writer
  I want to log in to the BetaBuddy Server
  So that I can get and give feedback on my prose} do
    # * Site checks if the user is logged in
    # * If not logged in, site prompts for authenticated username and password
    # * If username and password does not match any existing account in server, and error is returned
    # * If username and password error is returned, a link to the Register page is provided
    # * To register, email, username, and password fields are required
    # * Once account is registration, validation/welcome email is sent to email provided
    # * If log in is valid, logs in

  it 'can find the register page' do
    visit '/users/sign_up'
    fill_in 'Email', with: 'doobee@yahoo.com'
    fill_in 'Username', with: 'doobs'
    fill_in 'Password', with: '12345678', match: :prefer_exact
    fill_in 'Password confirmation', with: '12345678'

    click_button 'Sign up'
  end

  it 'does not sign in when it does not include all the fields' do
    visit '/users/sign_up'
    fill_in 'Email', with: 'doobee@yahoo.com'
    click_button 'Sign up'

    expect(page).to have_content("can't be blank")
  end

end
