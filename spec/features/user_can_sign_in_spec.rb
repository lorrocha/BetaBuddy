require 'spec_helper'

feature "A viewer can register to authenticate", %{
  As a writer
  I want to log in to the BetaBuddy Server
  So that I can get and give feedback on my prose} do

  let(:user) {FactoryGirl.create(:user)}

  def successful_login
    visit root_path
    first(:link, "Sign In").click

    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password

    click_button 'Sign In'
  end


  scenario "an existing user specifies valid email and password" do
    successful_login
    expect(page).to have_content('Welcome Back!')
  end

  context "user is not given a link to sign in if they're already authenticated" do
    it 'does not show the sign in link on the pages' do
      successful_login
      expect(page).to_not have_content('Sign In')
    end

    it 'sign in cannot be accessed via url' do
      successful_login
      visit new_user_session_path
      expect(page).to have_content("Woops! Looks like you're already signed in!")
    end
  end

  context "user is not signed in when the password is wrong" do

    it 'has the wrong password' do
      visit root_path
      first(:link, "Sign In").click

      fill_in 'Email', with: user.email
      fill_in 'Password', with: 'bloop'
      click_button 'Sign In'
      expect(page).to have_content('Invalid email or password')
    end

    it 'has the wrong email' do
      visit root_path
      first(:link, "Sign In").click

      fill_in 'Email', with: 'user.email344'
      fill_in 'Password', with: user.password
      click_button 'Sign In'
      expect(page).to have_content('Invalid email or password')
    end
  end

end
