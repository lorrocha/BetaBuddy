require 'spec_helper'

feature 'The owner of a prose can edit his/her prose',%q{
    As an authenticated user
    I want to edit the prose I already uploaded
    so that I can offer a more polished piece to be critiqued
} do
    # Authenticated user can access page via 'Edit' button
    # If not an authenticated user, redirected to the login page
    # Converts prose from the browser into a text box (where edits can be freely made)
    # Optionally can assign one or more than one genre tag to the prose
    # "Save" button saves the overwrites the original file, replacing its old content
    # When "Save" is used, browser is redirected to the page displaying the newly editted prose

  let(:molly) {FactoryGirl.create(:user)}
  let(:fanfic) {FactoryGirl.create(:prose, user_id:molly.id)}

  def sign_in(user)
    visit new_user_session_path
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Sign In"
  end

  context 'The user is the owner of the prose' do
    scenario 'can see the link to edit their prose' do
      sign_in(molly)
      visit "/users/#{fanfic.user_id}/proses/#{fanfic.id}"

      expect(page).to have_content(fanfic.description)
      expect(page).to have_content(fanfic.title)
      expect(page).to have_content(molly.username)
      expect(page).to have_content('Edit')
    end

    scenario 'can edit their page' do
      sign_in(molly)
      visit "/users/#{fanfic.user_id}/proses/#{fanfic.id}"
      click_on 'Edit'

      title= 'The VERY best story ever!'
      fill_in "Title", with: title
      click_button "Edit Prose"
      expect(page).to have_content(title)
    end
  end

  context 'The user is not the owner of the prose' do
    scenario 'can see the link to beta-read the prose' do
      sarah = FactoryGirl.create(:user)
      sign_in(sarah)
      visit "/users/#{fanfic.user_id}/proses/#{fanfic.id}"

      expect(page).to have_content(fanfic.description)
      expect(page).to have_content(fanfic.title)
      expect(page).to have_content(molly.username)
      expect(page).to have_content('Beta-Read!')
    end

    scenario 'can beta-read the prose' do
      sarah = FactoryGirl.create(:user)
      sign_in(sarah)
      visit "/users/#{fanfic.user_id}/proses/#{fanfic.id}"
      save_and_open_page
      click_on 'Beta-Read!'

      desc= 'The VERY best story ever! ZOMEGGGG'
      fill_in "Story", with: desc
      click_button "Submit Review"

      expect(page).to have_content("Your edits have been submitted. #{molly.username} will be seeing them soon!")
    end
  end


end
