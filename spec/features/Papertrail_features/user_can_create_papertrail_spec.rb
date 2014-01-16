require 'spec_helper'

feature 'A user can select a version of prose' do

  let(:molly) {FactoryGirl.create(:user)}
  let(:fanfic) {FactoryGirl.create(:prose, user_id:molly.id)}

  def sign_in(user)
    visit new_user_session_path
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Sign In"
  end

  # scenario 'the owner can update the prose automatically', :versioning => true do
  #   sign_in(molly)
  #   old_title = fanfic.title

  #   visit "/users/#{fanfic.user_id}/proses/#{fanfic.id}"
  #   click_on 'Edit'
  #   title= 'The VERY best story evewmfjkwefr!'
  #   fill_in "Title", with: title
  #   click_button "Edit Prose"

  #   expect(page).to have_content(title)
  # end

  # scenario 'a beta-reader cannot update prose automatically', :versioning => true do
  #   sally = FactoryGirl.create(:user)
  #   sign_in(sally)
  #   old_title = fanfic.title

  #   visit "/users/#{fanfic.user_id}/proses/#{fanfic.id}"
  #   click_on 'Beta-Read!'
  #   title= 'The VERY best story evewmfjkwefr!'
  #   fill_in "Title", with: title
  #   click_button "Submit Review"

  #   expect(page).to have_content(old_title)
  # end

end
