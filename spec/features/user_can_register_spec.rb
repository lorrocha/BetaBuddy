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

  let(:user) {FactoryGirl.create(:user)}

  it 'can register' do
    visit '/users/sign_up'
    fill_in 'Email', with: 'wahoo@weehee.com'
    fill_in 'Username', with: user.username
    fill_in 'user_password', with: user.password
    fill_in 'Password confirmation', with: user.password

    click_button 'Sign up'
    expect(page).to have_content('Welcome, warrior of the pen!')
  end

  context 'it does not register' do
    it 'when it does not include all the fields' do
      visit '/users/sign_up'
      click_button 'Sign up'

      expect(page).to have_content("can't be blank")
    end

    it 'when password confimation does not match' do
      visit '/users/sign_up'
      fill_in 'Email', with: user.email
      fill_in 'Username', with: user.username
      fill_in 'user_password', with: user.password
      fill_in 'Password confirmation', with: '12345675'

      click_button 'Sign up'
      expect(page).to have_content("doesn't match")
    end

    it 'when an account has been made with that email already' do
      FactoryGirl.create(:user)

      visit '/users/sign_up'
      fill_in 'Email', with: user.email
      fill_in 'Username', with: 'doobs'
      fill_in 'user_password', with: '12345678'
      fill_in 'Password confirmation', with: '12345678'
      click_button 'Sign up'

      expect(page).to have_content('has already been taken')
    end
  end



end
