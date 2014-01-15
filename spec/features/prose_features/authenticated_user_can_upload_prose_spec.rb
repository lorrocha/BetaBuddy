require 'spec_helper'

feature 'Authenticated User Can Upload Prose', %q{
    As an authenticated user
    I want to upload my prose onto the BetaBuddy server
    So that I can receive feedback on it
} do
  # * Authenticated users can access 'Add Prose' page
  # * Unauthenticated users are directed to the login page
  # * Offers a large text box for users to copy/paste their prose into
  # * Optionally can assign one or more than one genre tag to the prose
  # * Offers a 'Done' button which saves the input in the text box into a file on the server
  # * When 'Done' button is pressed, browser is redirected to a page displaying the prose
  # * Save as a markdown file?

  let(:user) {FactoryGirl.create(:user)}
  let!(:genre) {FactoryGirl.create(:genre)}

  def successful_login
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Sign In'
  end

  context 'only authenticated users can access new prose page' do
    it 'authenticated users can access "New prose" page on main nav' do
      successful_login

      visit 'proses/new'
      expect(page).to have_content('Title')
    end

    it 'non-authenticated users are prompted to authenticate' do
      visit '/proses/new'
      expect(page).to have_content('You need to sign in or sign up before continuing.')
    end
  end

  context 'a prose can be made' do
    it 'can be created with valid attributes' do
      successful_login

      visit 'proses/new'
      fill_in 'Title', with: 'Best Title Ever'
      fill_in 'Story', with: 'Omg there is dragons and stuff'
      click_button 'Create Prose'
      expect(page).to have_content('Your ink has been committed to paper.')
    end

    it 'can be created with a genre' do
      successful_login

      visit 'proses/new'
      fill_in 'Title', with: 'Best Title Ever'
      fill_in 'Story', with: 'Omg there is dragons and stuff'
      select genre.name, from: 'Genre'
      click_button 'Create Prose'
      expect(page).to have_content('Your ink has been committed to paper.')
      expect(page).to have_content(genre.name)
    end

    it 'cannot be created without a description' do
      successful_login

      visit 'proses/new'
      fill_in 'Title', with: 'Weeee'
      click_button 'Create Prose'
      expect(page).to have_content("can't be blank")
    end
  end

  context 'New Prose button on the nav bar' do
    scenario 'appears for authenticated users' do
      successful_login

      visit root_path
      expect(page).to have_content('New Story')
    end

    scenario 'appears for authenticated users' do
      visit root_path
      expect(page).to_not have_content('New Story')
    end
  end
end
